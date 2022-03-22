//
//  DigitWebServiceClient.swift
//  DigitWSClient
//
//  Created by Sarah Jmaiel on 22/02/2019.
//  Copyright © 2019 Sarah Jmaiel. All rights reserved.
//

import Foundation

public class DigitWebServiceClient {
    
    let session: URLSession
    let baseURL: [String: Any]
    public let encoder = JSONEncoder()
    public let decoder = JSONDecoder()
    public var timeOutRequest = WebServicesKeys.timeOutDuration
    
    public init(baseURL: [String: Any]) {
        self.session = .shared
        self.baseURL = baseURL
    }
    
    func sendRequest(urlPth: String, httpMethod: MethodHttp, bodyParams: [String: Any], paramsRequest: [String: String], headers: [String: String], completion: @escaping (Result<(Data)>) -> Void) {
        
        let components = NSURLComponents()
        
        components.scheme = self.baseURL[WebServicesKeys.schemeKey] as? String ?? ""
        components.host = self.baseURL[WebServicesKeys.hostKey] as? String ?? ""
        
        if let portURL = self.baseURL[WebServicesKeys.portKey] as? Int, portURL > 0 {
            components.port = NSNumber(value: portURL)
        }

        let apiVersion = self.baseURL[WebServicesKeys.versionKey] as? String ?? ""
        components.path = apiVersion + urlPth
        
        var itemsComponents: [URLQueryItem] = []
        paramsRequest.forEach { (key, value) in
            let queryItem = URLQueryItem(name: key, value: value.addingPercentEncoding(withAllowedCharacters: .alphanumerics))
            itemsComponents.append(queryItem)
        }
        
        if !itemsComponents.isEmpty {
            components.queryItems = itemsComponents
        }
        
        guard let url = components.url else {
            debugPrint("DigitWebServiceClient --> Url is broken")
            return
        }
        
        debugPrint("DigitWebServiceClient --> Url is \(url.absoluteString)")
        
        guard let validURL = URL(string: url.absoluteString.removingPercentEncoding ?? "") else {
            return
        }
        
         debugPrint("DigitWebServiceClient --> Valid Url is \(validURL.absoluteString)")
        
        let request = NSMutableURLRequest(url: validURL)
        request.timeoutInterval = timeOutRequest
        request.httpMethod = httpMethod.rawValue
        
        if httpMethod != .get {
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyParams, options: .prettyPrinted)
        }
        
        if !headers.isEmpty {
            request.allHTTPHeaderFields = headers
        }
        
        let task = self.session.dataTask(with: request as URLRequest) { (data, _, error) in
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(error))
            }
        }
        
        task.resume()
        
    }
    
    public func sendJSONRequest(urlPth: String, httpMethod: MethodHttp, paramsGetRequest: [String: String], bodyParams: [String: Any], headers: [String: String], completion: @escaping (Result<Data>) -> Void) {
        
        sendRequest(urlPth: urlPth, httpMethod: httpMethod, bodyParams: bodyParams, paramsRequest: paramsGetRequest, headers: headers) { (dataResult) in
            switch dataResult {
            case .success(let data):
                do {
                    _ = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(.success(data))
                } catch let error {
                    debugPrint("DigitWebServiceClient --> Serialization error :: \(error.localizedDescription)")
                    completion(.failure(error))
                }
                
            case .failure(let error):
                debugPrint("DigitWebServiceClient --> JSON converting error :: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    public func jsonFormatter<EncodableStruct: Any>(object: EncodableStruct) -> [String: Any] where EncodableStruct: Encodable {
        
        guard let dataObject = try? encoder.encode(object) else {
            return [:]
        }
        
        guard let jsonObject = try? JSONSerialization.jsonObject(with: dataObject, options: []) as? [String: Any] else {
            return [:]
        }
        
        return jsonObject ?? [:]
        
    }
    
    // construct server url and return it as a string
    public func retrieveURLRessources(urlRessoucePath: String) -> String? {
        
        let components = NSURLComponents()
        
        components.scheme = baseURL[WebServicesKeys.schemeKey] as? String ?? ""
        components.host = baseURL[WebServicesKeys.hostKey] as? String ?? ""
        
        if let portURL = baseURL[WebServicesKeys.portKey] as? Int, portURL > 0 {
            components.port = NSNumber(value: portURL)
        }
        
        components.path = urlRessoucePath
        
        guard let url = components.url else {
            debugPrint("DigitWebServiceClient --> Url Ressource is broken")
            return nil
        }
        
        debugPrint("DigitWebServiceClient --> Url Ressource is \(url.absoluteString)")
        
        return url.absoluteString
    }
    
    // Add  Method to send request and parse decoded object(s)
    public func sendAndDecodeJSONRequest<T:Decodable>(urlPth: String, httpMethod: MethodHttp, paramsGetRequest: [String: String], bodyParams: [String: Any], headers: [String: String],of type: T.Type, completion: @escaping (Result<T>) -> Void) {
        
        sendRequest(urlPth: urlPth, httpMethod: httpMethod, bodyParams: bodyParams, paramsRequest: paramsGetRequest, headers: headers) { (dataResult) in
            switch dataResult {
            case .success(let data):
                do {
                    let objectToReturn: T = try self.decoder.decode(T.self, from: data)
                    completion(.success(objectToReturn))
                } catch let error {
                    debugPrint("DigitWebServiceClient --> Serialization error :: \(error.localizedDescription)")
                    completion(.failure(error))
                }
                
            case .failure(let error):
                debugPrint("DigitWebServiceClient --> JSON converting error :: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        
    }
}
