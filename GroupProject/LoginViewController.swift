//
//  LoginViewController.swift
//  GroupProject
//
//  Created by AAAVPrakash12 on 11/8/22.
//

import UIKit
import FirebaseAuth
import CoreData

var account:String = ""
var currentUser:NSManagedObject?

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

let bgColor = UIColor(red: 246/255.0, green: 216/255.0, blue: 156/255.0, alpha: 1.0)

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
        
        view.backgroundColor = bgColor
        
        pwField.isSecureTextEntry = true
        confirmLabel.text = ""
        confirmField.isHidden = true
        confirmField.isSecureTextEntry = true
        errorMsg.text = ""
        
        if let attrFont = UIFont(name: "Noteworthy", size: 30) {
            let title = "Sign In"
            let attrTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: attrFont])
            logsignButton.setAttributedTitle(attrTitle, for: UIControl.State.normal)
        }
        
        // do not uncomment/delete:
        // clearUserData()
        
        // TODO: add/edit core data
            // if not, add warning that progress is deleted
        // TODO: constrain everything
            //  if possible, constrain labels to crossword
            
    }
    
    @IBAction func onSegmentChanged(_ sender: Any) {
        switch segCtrl.selectedSegmentIndex {
        case 0:
            confirmLabel.text = ""
            confirmField.isHidden = true
            if let attrFont = UIFont(name: "Noteworthy", size: 30) {
                let title = "Sign In"
                let attrTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: attrFont])
                logsignButton.setAttributedTitle(attrTitle, for: UIControl.State.normal)
            }
        case 1:
            confirmLabel.text = "Confirm Password"
            confirmField.isHidden = false
            if let attrFont = UIFont(name: "Noteworthy", size: 30) {
                let title = "Sign Up"
                let attrTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: attrFont])
                logsignButton.setAttributedTitle(attrTitle, for: UIControl.State.normal)
            }
        default:
            logsignButton.setTitle("Error", for: .normal)
        }
        
    }
    
    func clearUserData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Settings")
        var fetchedResults:[NSManagedObject]

        do {
            try fetchedResults = context.fetch(request) as! [NSManagedObject]

            if fetchedResults.count > 0 {
                for result:AnyObject in fetchedResults {
                    context.delete(result as! NSManagedObject)
                    print("\(result) has been deleted")
                }
            }
            saveContext()

        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }

    }
    
    
    @IBAction func loginPressed(_ sender: Any) {
        if logsignButton.titleLabel!.text == "Sign In" {
            Auth.auth().signIn(withEmail: emailField.text!, password: pwField.text!) {
                authResult, error in
                if let error = error as NSError? {
                    self.errorMsg.text = "\(error.localizedDescription)"
                } else {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Settings")
                    let sortDescriptor = NSSortDescriptor(key: "accountEmail", ascending: true)
                    fetchRequest.sortDescriptors = [sortDescriptor]
                    do {
                        let users = try context.fetch(fetchRequest) as! [NSManagedObject]
                        if users.count == 0 {
                            let settings = NSEntityDescription.insertNewObject(forEntityName: "Settings", into: context)
                            account = self.emailField.text!
                            settings.setValue(account, forKey: "accountEmail")
                            settings.setValue("Noob", forKey: "gameMode")
                            settings.setValue(true, forKey: "showTime")
                            settings.setValue(true, forKey: "showTries")
                            self.saveContext()
                        }
                        for user in users {
                            if user.value(forKey: "accountEmail") as! String == self.emailField.text! {
                                currentUser = user
                            }
                        }
                    } catch {
                        print(error)
                    }
                    
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
                        let settings = NSEntityDescription.insertNewObject(forEntityName: "Settings", into: context)
                        account = self.emailField.text!
                        settings.setValue(account, forKey: "accountEmail")
                        settings.setValue("Noob", forKey: "gameMode")
                        settings.setValue(true, forKey: "showTime")
                        settings.setValue(true, forKey: "showTries")
                        self.saveContext()
                    }
                }
            } else {
                errorMsg.text! = "Passwords do not match"
            }
        }
    }
    
    func saveContext() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

