# DigitWebServiceClient
DigitWebServiceClient is a library that helps swift users to invoke their WebServices

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 11 or higher.

## Overview

DigitWebServiceClient is a lightweight web client that allows you to invoke webservices with JSON Response

## Usage

1/ You need first of all to instantiate your webClient with your server informations like so:

```ruby
// Instantiate webClient
    let baseURL: [String: Any] = [
        WebServicesKeys.schemeKey: "http",
        WebServicesKeys.hostKey: "www.json-generator.com",
        WebServicesKeys.versionKey: "/api",
        WebServicesKeys.portKey: 0]
    let webClient = DigitWebServiceClient(baseURL: baseURL)
```
2/ Create a Decodable struct for the returned object in my case I have an Array of Film objects:

```ruby
struct Film: Decodable {
    
    let title: String
    let text: String
    let longitude: Double
    let latitude: Double
    let intro: String
    let year: Int
    let images: [String]
    
    private enum CodingKeys: String, CodingKey {
        case title
        case text
        case longitude
        case latitude
        case intro
        case year
        case images
    }
}

```
3/ Create an Extension for your DigitWebServiceClient like below:

```ruby
extension DigitWebServiceClient {
    
    func fetchFilms(completion: @escaping (Result<[Film]>) -> Void) {
        
        let filmsURL = "/json/get/bUAxzJkxhK"
        let params = ["indent": "2"]
        
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
```

* urlPth param: specify your endpoint
* httpMethod param: specify your http method 
* paramsGetRequest param: specify your dictionary of get request params
* bodyParams param: specify your dictionary of post/put request params
* headers param: specify your dictionary of headers request params

4/ Come back to your webClient's instantiation so you can get the final result :

```ruby
  webClient.fetchFilms(completion: { (result) in
        switch result{
        case .success(let films):
            for aFilm in films {
                print("The film title is \(aFilm.title)")
            }
            
        case .failure(let error):
            print("The error is \(error.localizedDescription)")
        }
    })
```

## Installation

DigitWebServiceClient is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DigitWebServiceClient'
```

## Author

sarrajbs, jmail.sarah@gmail.com

## License

DigitWebServiceClient is available under the MIT license. See the LICENSE file for more info.

