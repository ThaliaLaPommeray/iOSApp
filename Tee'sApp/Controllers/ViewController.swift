//
//  ViewController.swift
//  Tee'sApp
//
//  Created by La Pommeray, Thalia on 10/25/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
        
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var apiActivityIndicator: UIActivityIndicatorView!
    
    
    var data = ["butterfly", "dog", "cat", "mouse", "rabbit", "bat", "chimpanzee", "donkey",
                "dinosaur", "duck", "eagle", "goldfish"]
    let activityIndicator = UIActivityIndicatorView()
    var userName:String = ""
    var viewModel = InfoViewModel()
    var userDataHolder: [User] = []
    var userData: [User] = []
    var userIndex: Int = 0
    var user = User.dummyUser()
    

    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view.

        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self

        //delegating search field so a keyboard push registers as the 'return; key
        searchField.delegate = self
        //networking data(:
        viewModel.fetchData()
        apiActivityIndicator.startAnimating()
    }
    
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchField.endEditing(true)
        userName = searchField.text!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let landingVC = segue.destination as? ViewControllerB else{
            return
        }
        
        //data we plan to pass to our landing ViewController
        landingVC.info = userName
        landingVC.userData = userData
        landingVC.userIndex = userIndex
        landingVC.user = user
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate{
    // Returns the number of rows for the table.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.count
    }
    
    // Provides a cell object for each row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellone", for: indexPath)
        
        
            let index = indexPath.row % data.count
                    
        let title = userData[index].username
            
            // configures cell’s contents.
            cell.textLabel!.text = title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if let title = cell?.textLabel?.text {
            print(title)
            userName = userData[indexPath.row].name
            userIndex = indexPath.row
            user = userData[indexPath.row]
            performSegue(withIdentifier: "first", sender: nil)
        }
            
        }
    
    // MARK: - UIAlertController
    func showSimpleAlert(description: String) {
        // UIAlert that gives uer option to retry API call or to simple cancel
        let alert = UIAlertController(title: "Error Pulling Data", message: description,   preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: { (action)-> Void in
            self.viewModel.fetchData()
        }))

        //Cancel Action
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
        }))

        self.present(alert, animated: true, completion: nil)
    }
        
    
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate{
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.endEditing(true)
        print(searchField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
            
        } else {
            textField.placeholder = "Search"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //func to get user input of search text field
        if let username = searchField.text {
            userName = username
        }
        searchField.text = ""
        userData = userDataHolder
        tableView.reloadData()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // func that is called at every character press
        let text: NSString = (textField.text ?? "") as NSString
        // string that is passed to VM to sort through current user array
        let resultString = text.replacingCharacters(in: range, with: string)
        print(resultString)
        userData = (viewModel.findUser(userSearch: resultString))
        tableView.reloadData()
        return true
    }

}

// MARK: - TableDataDelegate - API Call Delegate
extension ViewController: TableDataDelegate{
    func errorOccurred(description: String){
        showSimpleAlert(description: description)
        print(description)
    }
    func dataReceived(users: [User]){
        if !users.isEmpty{
            print("Data received... reloading table")
        }
        
        for user in users{
//            print(user.username)
            data.append(user.username)
        }
        userData = users
        userDataHolder = users
        
        tableView.reloadData()
        apiActivityIndicator.stopAnimating()


    }
    
}


