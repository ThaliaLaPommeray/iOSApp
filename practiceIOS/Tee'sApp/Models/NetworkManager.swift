//
//  CodableExample.swift
//  Tee'sApp
//
//  Created by La Pommeray, Thalia on 11/2/22.
//

import Foundation

enum ServiceError {
    case invalidURL
    case noReturnData
    // Enum case with an "associated value" which can be passed along with the case .networkingError
    // See how it's used in `func updatedFetchInfo(:)`
    case networkingError(Error)
    case decodingError(Error)
}

class NetworkManager {
    
    let urlString = "https://jsonplaceholder.typicode.com/posts"
    
    var data: [Info] = []
    
     func fetchInfo(){
        performRequest(urlString: urlString)
    }
  
    // The closure `completion` contains two optional values, an array of Info objects and a ServiceError
    // ServiceError is an enum object I created above, which creates a nice way to log / send back any errors that may occur to whoever is calling this function
    // The closure is marked as `@escaping` since this closure can "outlive the scope that you pass in", this probably doesn't make sense
    // It basically means that this function could potentially never complete if for some reason this class was deallocated before the networking call completes
    func updatedFetchInfo(completion: @escaping ([Info]?, ServiceError?) -> ()) {
        guard let url = URL(string: urlString) else {
            completion(nil, .invalidURL)
            return
        }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            // Check for error, if we have one, return error
            guard error == nil else {
                // Enumerations can have "associated types", so we can pass in the actual error we get from URLSession, back in the completion handler here
                completion(nil, .networkingError(error!))
                return
            }
            
            // Ensure we have received response data
            guard let responseData = data else {
                completion(nil, .noReturnData)
                return
            }
            
            // Same functionality as your `func parseJSON`
            do {
                // Attempt to decode into [Info]
                let infoArray = try JSONDecoder().decode([Info].self, from: responseData)
                // Return [Info] back in completion handler with ServiceError as nil
                completion(infoArray, nil)
            } catch let error {
                // Decoding failed, send back decoding error message in completion closure
                // Since this catch block provides us with an `error` object, we can send that back within the closure as well using our ServiceError.decodingError() which allows for an Error associated value
                completion(nil, .decodingError(error))
            }
        }.resume()
    }
    
    private func performRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    // inside closures, calls to methods that are inside the class must include "self"
                    self.parseJSON(data: safeData)
                }
            }
            
            task.resume()
        }
    }
    
    private func parseJSON(data: Data){
        do {
            let decodedData = try JSONDecoder().decode([Info].self, from: data)
            print(decodedData[1].userId)
            print(decodedData[1].title)
            print(decodedData[1].id)
            print(decodedData[1].body)
            self.data = decodedData
        } catch{
            print(error)
        }
    }
}


struct Info: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
