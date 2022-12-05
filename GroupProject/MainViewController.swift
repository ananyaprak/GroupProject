//
//  MainViewController.swift
//  GroupProject
//
//  Created by AAAVPrakash12 on 11/20/22.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    
    @IBOutlet weak var htpButton: UIButton!
    @IBOutlet weak var tableButton: UIButton!
    @IBOutlet weak var lgtButton: UIButton!
    @IBOutlet weak var stgButton: UIButton!
    @IBOutlet weak var prflButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = bgColor
        
        htpButton.setAttributedTitle(NSAttributedString(string: "How To Play", attributes: [NSAttributedString.Key.font: UIFont(name: "Noteworthy", size: 20)!]), for: .normal)
        tableButton.setAttributedTitle(NSAttributedString(string: "Puzzles", attributes: [NSAttributedString.Key.font: UIFont(name: "Noteworthy", size: 30)!]), for: .normal)
        lgtButton.setAttributedTitle(NSAttributedString(string: "Logout", attributes: [NSAttributedString.Key.font: UIFont(name: "Noteworthy", size: 20)!]), for: .normal)
        stgButton.setAttributedTitle(NSAttributedString(string: "Settings", attributes: [NSAttributedString.Key.font: UIFont(name: "Noteworthy", size: 20)!]), for: .normal)
        prflButton.setAttributedTitle(NSAttributedString(string: "Profile", attributes: [NSAttributedString.Key.font: UIFont(name: "Noteworthy", size: 20)!]), for: .normal)
        
        htpButton.layer.borderWidth = 1
        htpButton.layer.cornerRadius = 10
        htpButton.layer.borderColor = UIColor.black.cgColor
        
        tableButton.layer.borderWidth = 1
        tableButton.layer.cornerRadius = 10
        tableButton.layer.borderColor = UIColor.black.cgColor
        
        lgtButton.layer.borderWidth = 1
        lgtButton.layer.cornerRadius = 10
        lgtButton.layer.borderColor = UIColor.black.cgColor
        
        stgButton.layer.borderWidth = 1
        stgButton.layer.cornerRadius = 10
        stgButton.layer.borderColor = UIColor.black.cgColor
        
        prflButton.layer.borderWidth = 1
        prflButton.layer.cornerRadius = 10
        prflButton.layer.borderColor = UIColor.black.cgColor
        
        
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
