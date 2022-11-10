//
//  DataViewModel.swift
//  Tee'sApp
//
//  Created by La Pommeray, Thalia on 11/8/22.
//

import Foundation

class InfoViewModel {

    private let manager = NetworkManager()
    // private(set) is a very nice access control modifier, allowing objects to see that InfoViewModel has a `infoData` variable, but won't let anything change the variable
    private(set) var infoData: [Info] = []

    init(){
        manager.fetchInfo()
    }

    func fetchData()->[Info]{
        manager.data
    }
    
    func updatedFetchData() {
        /*
         Take note of the updated function structure
         manager.updatedFetchInfo(completion: <#T##([Info]?, ServiceError?) -> ()#>)
         
         Expanded out, this looks like:
         
         manager.updatedFetchInfo { <#[Info]?#>, <#ServiceError?#> in
             
         }
         
         This is very similar to how the URLSession data task function is structure, giving us back a closure to work with
         session.dataTask(with: <#T##URLRequest#>, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
         
         But now we get back a few things from our manager.updatedFetchInfo() function which we can work with
         
        */
        manager.updatedFetchInfo { [weak self] infoArray, error in
            guard error == nil else {
                // We have received an error during our networking call, this error is of type ServiceError (which is the custom enum we created)
                // Since we handled different errors and put these within the ServiceError enum, we now can debug easily whether it's a networking issue, decoding issue, etc
                // this may be a good place to have an alert view pop up, notifying the user of the error
                return
            }
            
            guard let infoArray = infoArray else {
                // If we don't have an infoArray AND if error == nil (above), then there is something we didn't handle within our NetworkManager function
                // It wouldn't really make sense that this is nil AND we didn't get an error above
                // print("something went really wrong, or we didn't handle the error correctly within updatedFetchInfo()")
                return
            }
            
            // At this point, we have confirmed there are no errors and we have our array full of Info objects from the server
            self?.infoData = infoArray
        }
    }
}
