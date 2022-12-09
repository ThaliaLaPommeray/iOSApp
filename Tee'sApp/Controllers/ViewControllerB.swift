//
//  FirstViewController.swift
//  Tee'sApp
//
//  Created by La Pommeray, Thalia on 10/27/22.
//

import UIKit

class ViewControllerB: UIViewController {
    
    var info: String?;
    let manager = InfoViewModel()
    var userData:[User] = []
    var user = User.dummyUser()
    var userIndex = 0
    var infoForAlert:String = ""
    
    @IBOutlet weak var userChoice: UILabel!
    
    @IBOutlet weak var userStreetAddress: UILabel!
    
    @IBOutlet weak var addressSuiteLabel: UILabel!
    
    @IBOutlet weak var addressCityLabel: UILabel!
    @IBOutlet weak var userPhoneNumLabel: UILabel!
    
    @IBOutlet weak var userEmailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad();
        
        // User info that will be displayed
        userChoice.text = info
        userStreetAddress.text? = ("\(user.address.street)")
        addressSuiteLabel.text? = user.address.suite
        var addy = "\(user.address.city) "
        addy.append(user.address.zipcode)
        addressCityLabel.text? = addy
        userPhoneNumLabel.text? = user.phone
        userEmailLabel.text? = user.email
        
    }
    
    @IBAction func viewDataButtonPressed(_ sender: UIButton) {
                self.showSimpleAlert()
    }
    
    
    @IBAction func returnButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func showSimpleAlert() {
        let alert = UIAlertController(title: "Data", message: "Just here to say hi!",   preferredStyle: UIAlertController.Style.alert)
        //Cancel Action
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func editDataButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure?", message: "This will change any current data",   preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Edit", style: UIAlertAction.Style.default, handler: { _ in
        }))
        //Cancel Action
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
        }))

        self.present(alert, animated: true, completion: nil)
    }
    

}
