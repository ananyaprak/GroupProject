//
//  LoginViewController.swift
//  GroupProject
//
//  Created by AAAVPrakash12 on 11/8/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var confirmField: UITextField!
    @IBOutlet weak var errorMsg: UILabel!
    @IBOutlet weak var logsignButton: UIButton!
    @IBOutlet weak var segCtrl: UISegmentedControl!
    @IBOutlet weak var confirmLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pwField.isSecureTextEntry = true
        confirmLabel.text = ""
        confirmField.isHidden = true
        emailField.text = emailSaved
        
        // TODO: add crossle logo
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailField.text = emailSaved
    }
    
    @IBAction func onSegmentChanged(_ sender: Any) {
        switch segCtrl.selectedSegmentIndex {
        case 0:
            logsignButton.setTitle("Sign In", for: .normal)
            confirmLabel.text = ""
            confirmField.isHidden = true
        case 1:
            logsignButton.setTitle("Sign Up", for: .normal)
            confirmLabel.text = "Confirm Password"
            confirmField.isHidden = true
        default:
            logsignButton.setTitle("Error", for: .normal)
        }
    }
    
    
    @IBAction func loginPressed(_ sender: Any) {
        if logsignButton.titleLabel!.text == "Sign In" {
            Auth.auth().signIn(withEmail: emailField.text!, password: pwField.text!) {
                authResult, error in
                if let error = error as NSError? {
                    self.errorMsg.text = "\(error.localizedDescription)"
                } else {
                    self.errorMsg.text = ""
                    self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                    self.emailField.text = nil
                    self.pwField.text = nil
                }
            }
        } else if logsignButton.titleLabel!.text == "Sign Up" {
            if pwField.text! == confirmField.text! {
                Auth.auth().createUser(withEmail: emailField.text!, password: pwField.text!) {
                    authResult, error in
                    if let error = error as NSError? {
                        self.errorMsg.text = "\(error.localizedDescription)"
                    } else {
                        self.errorMsg.text = ""
                    }
                }
            } else {
                errorMsg.text! = "Passwords do not match"
            }
        }
    }
    
}

