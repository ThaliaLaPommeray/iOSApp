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
//    var apiData: [Info]
    @IBOutlet weak var choice: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad();

        choice.text = info
    }
    
    @IBAction func viewDataButtonPressed(_ sender: UIButton) {
        manager.fetchData()
    }
    
    
    @IBAction func returnButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
