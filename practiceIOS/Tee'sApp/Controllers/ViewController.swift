//
//  ViewController.swift
//  Tee'sApp
//
//  Created by La Pommeray, Thalia on 10/25/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{

    @IBOutlet weak var tableView: UITableView!
        
    @IBOutlet weak var searchField: UITextField!
    
    let data = ["butterfly", "dog", "cat", "mouse", "rabbit", "bat", "chimpanzee", "donkey",
                "dinosaur", "duck", "eagle", "goldfish"]
    
    var passedString:String = ""

    // Asks the data source to return the number of sections in the table view.
    func numberOfSections(in tableView: UITableView) -> Int {
        // dont even need a return statement in Swift
         5
    }
    
    // Returns the number of rows for the table.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    // Provide a cell object for each row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellone", for: indexPath)
        let index = indexPath.row % data.count
                
        let title = data[index]
        
        // configures the cell’s contents.
        cell.textLabel!.text = title
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if let title = cell?.textLabel?.text {
            print(title)
            passedString = title
            performSegue(withIdentifier: "first", sender: nil)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        tableView.delegate = self
        tableView.dataSource = self
        //delegating so a keyboard push of "return" is like pressing the search key
        searchField.delegate = self
    }

    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.endEditing(true)
        print(searchField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
            
        } else {
            textField.placeholder = "Search for an animal"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //func to get user input of search text field
        if let animal = searchField.text {
            passedString = animal
            performSegue(withIdentifier: "first", sender: nil)
        }
        searchField.text = ""
    }

    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchField.endEditing(true)
        passedString = searchField.text!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let landingVC = segue.destination as? ViewControllerB else{
            return
        }
        landingVC.info = passedString
    }
}

