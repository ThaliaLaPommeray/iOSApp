//
//  CodableExample.swift
//  Tee'sApp
//
//  Created by La Pommeray, Thalia on 11/2/22.
//

import Foundation

class NetworkManager {
    let urlString = "https://jsonplaceholder.typicode.com/users"
    var dataInfo: [User] = []
    
    // a compeltion handler!
    // this ties into a closure in the VM
    // @escaping is used since we intend to use the numbers/data acquired after the function is finished
    // or the data will outlive the fucntion call
    func fetchInfo(completion: @escaping ([User]?,Error?)-> Void){
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
                // completion handler needs to be defined
                completion(self.dataInfo, nil)

            }
            task.resume()
        }
    }
    
    private func parseJSON(data: Data){
        do {
            let decodedData = try JSONDecoder().decode([User].self, from: data)
            print(decodedData[1].name)
            print(decodedData[1].address.street)
            
            
            dataInfo = decodedData
            
            if dataInfo.isEmpty{
                print("dataInfo is empty")
            }
            print("Parsing froom network manager done")
        } catch{
            print(error)
        }
    }
}

