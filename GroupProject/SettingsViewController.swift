//
//  SettingsViewController.swift
//  GroupProject
//
//  Created by AAAVPrakash12 on 11/21/22.
//

import UIKit
import CoreData

let settings = NSEntityDescription.insertNewObject(forEntityName: "Settings", into: context)

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var gameModeNew:String = "Noob"
    var showTimeNew:Bool = true
    var showTriesNew:Bool = true
    
    @IBOutlet weak var modePicker: UIPickerView!
    let pickerData = ["Noob", "Gamer", "Pro"]
    @IBOutlet weak var modeDescription: UILabel!
    
    @IBOutlet weak var timeSwitch: UISwitch!
    @IBOutlet weak var triesSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = bgColor
        
        self.modePicker.delegate = self
        self.modePicker.dataSource = self
        
        setModeDescription()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        modePicker.selectRow(pickerData.firstIndex(of: currentUser?.value(forKey: "gameMode") as! String)!, inComponent: 0, animated: true)
        setModeDescription()
        
        timeSwitch.setOn(currentUser?.value(forKey: "showTime") as! Bool, animated: false)
        triesSwitch.setOn(currentUser?.value(forKey: "showTries") as! Bool, animated: false)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gameModeNew = pickerData[row]
        currentUser?.setValue(gameModeNew, forKey: "gameMode")
        saveContext()
        setModeDescription()
    }
    
    func setModeDescription() {
        if gameModeNew == "Noob" {
            modeDescription.text = "Green, Yellow, and Red Wordle clues will show."
        } else if gameModeNew == "Gamer" {
            modeDescription.text = "Yellow and Red World clues will show, Green will not."
        } else if gameModeNew == "Pro" {
            modeDescription.text = "No Worlde clues will show."
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
    
    @IBAction func timeSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            showTimeNew = true
        } else {
            showTimeNew = false
        }
        timeSwitch.setOn(showTimeNew, animated: true)
        currentUser?.setValue(showTimeNew, forKey: "showTime")
        saveContext()
    }
    
    
    @IBAction func triesSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            showTriesNew = true
        } else {
            showTriesNew = false
        }
        triesSwitch.setOn(showTriesNew, animated: true)
        currentUser?.setValue(showTriesNew, forKey: "showTries")
        saveContext()
    }

}
