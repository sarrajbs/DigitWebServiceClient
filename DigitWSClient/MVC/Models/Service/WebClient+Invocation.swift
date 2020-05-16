//
//  WebClient+Invocation.swift
//  DigitWSClient
//
//  Created by Sarah Jmaiel on 22/02/2019.
//  Copyright © 2019 Sarah Jmaiel. All rights reserved.
//

import Foundation

extension DigitWebServiceClient {
    
    func fetchFilms(completion: @escaping (Result<[Film]>) -> Void) {
        
        let filmsURL = Route.getFilms.description
        let params = ["indent": "2"]
        
        // if you have an encodable struct that you want to convert it into a Dictionary of body parms
        let objectToSent = ObjectToSend(name: "Sarah", job: "iOS")
        let bodyParams = jsonFormatter(object: objectToSent)
        
        sendJSONRequest(urlPth: filmsURL, httpMethod: MethodHttp.get, paramsGetRequest: params, bodyParams: [:], headers: [:]) { (result) in
            //parsing result
            switch result {
            case .success(let data):
                do {
                    let filmsList = try self.decoder.decode([Film].self, from: data as Data)
                    if !filmsList.isEmpty {
                        completion(.success(filmsList))
                    } else {
                        completion(.success([]))
                    }
                    
                } catch let err {
                    debugPrint("Decoding object error :: \(err.localizedDescription)")
                    completion(.failure(err))
                }
                
            case .failure(let error):
                debugPrint("Failure WS with error :: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
}
