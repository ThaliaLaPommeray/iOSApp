
//  Created by La Pommeray, Thalia on 11/8/22.

import Foundation

// using AnyObject to make a protocol work with 'weak' keyword,
// this limits a protocol adoption to class types
protocol TableDataDelegate: AnyObject {
    func errorOccurred(description: String)
    func dataReceived(users: [User])
}
class InfoViewModel {
    private(set) var users: [User] = [] {
        didSet{
            delegate?.dataReceived(users: users)
        }
    }
    
    weak var delegate: (TableDataDelegate)?
    var userData: [User] = []
    
    private let manager = NetworkManager()
    
    func fetchData(){
        manager.fetchInfo{ [weak self] users, error in
            guard let fetchedUsers = users else {
                self?.delegate?.errorOccurred(description: "No users returned from server")
                return
            }
            DispatchQueue.main.async {
                self?.users = fetchedUsers
                if (fetchedUsers.isEmpty){
                    print("fetchedUsers is empty")
                }
                self?.userData = fetchedUsers
//                self?.users.append(contentsOf: fetchedUsers)
            }
        }
    }
    
    func findUser(userSearch: String)->[User]{
        // searches array according to passed String
        var relevantUsers: [User] = []
        
        for users in userData{
            if users.username.contains(userSearch){
                relevantUsers.append(users)
            }
            
        }
        if userSearch.isEmpty{
            return userData
        }
        return relevantUsers
    }
}
