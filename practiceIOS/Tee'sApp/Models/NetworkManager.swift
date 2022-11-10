//
//  CodableExample.swift
//  Tee'sApp
//
//  Created by La Pommeray, Thalia on 11/2/22.
//

import Foundation

class NetworkManager {
    let urlString = "https://jsonplaceholder.typicode.com/posts"
    var data: [Info] = []
     func fetchInfo(){
        performRequest(urlString: urlString)
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
