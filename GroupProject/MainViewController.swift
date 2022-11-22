//
//  MainViewController.swift
//  GroupProject
//
//  Created by AAAVPrakash12 on 11/20/22.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true)
        } catch {
            print("Signout Error")
        }
    }
    
    @IBAction func puzzlesPressed(_ sender: Any) {}
    
    @IBAction func settingsPressed(_ sender: Any) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backButton = UIBarButtonItem()
        backButton.title = "Main Menu"
        navigationItem.backBarButtonItem = backButton
    }

}
