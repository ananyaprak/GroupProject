//
//  LoginViewController.swift
//  GroupProject
//
//  Created by AAAVPrakash12 on 11/8/22.
//

import UIKit
import FirebaseAuth
// import Foundation

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var confirmField: UITextField!
    @IBOutlet weak var errorMsg: UILabel!
    @IBOutlet weak var logsignButton: UIButton!
    @IBOutlet weak var segCtrl: UISegmentedControl!
    @IBOutlet weak var confirmLabel: UILabel!
    
    let start = DispatchTime.now()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pwField.isSecureTextEntry = true
        confirmLabel.text = ""
        confirmField.isHidden = true
        
        // TODO: add crossle logo
        
        Auth.auth().addStateDidChangeListener() {
            auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                self.emailField.text = nil
                self.pwField.text = nil
            }
        }
            
    }
    
    func convertSeconds(seconds:Int) {
        print("\(String(seconds / 3600)):\(String((seconds % 3600)/60)):\(String((seconds % 3600) % 60))")
    }
    
    @IBAction func time(_ sender: Any) {
        let end = DispatchTime.now()

        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)

        let current = DispatchTime.init(uptimeNanoseconds: nanoTime)

        let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests

        let seconds = Int(round(timeInterval))
        
        convertSeconds(seconds:seconds)
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

