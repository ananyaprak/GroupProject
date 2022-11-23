//
//  SettingsViewController.swift
//  GroupProject
//
//  Created by AAAVPrakash12 on 11/21/22.
//

import UIKit

var gameMode = "Noob"
var showTime = true
var showTries = true
var emailSaved = ""

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var modePicker: UIPickerView!
    let pickerData = ["Noob", "Gamer", "Pro"]
    @IBOutlet weak var modeDescription: UILabel!
    
    @IBOutlet weak var rememberEmail: UITextField!
    
    @IBOutlet weak var timeSwitch: UISwitch!
    @IBOutlet weak var triesSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modePicker.delegate = self
        self.modePicker.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        modePicker.selectRow(pickerData.firstIndex(of: gameMode)!, inComponent: 0, animated: true)
        setModeDescription()
        
        timeSwitch.setOn(showTime, animated: false)
        triesSwitch.setOn(showTries, animated: false)
        
        rememberEmail.text = emailSaved
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
        gameMode = pickerData[row]
        setModeDescription()
    }
    
    func setModeDescription() {
        if gameMode == "Noob" {
            modeDescription.text = "Noob description - green, yellow, and red wordle clues on"
        } else if gameMode == "Gamer" {
            modeDescription.text = "Gamer description - yellow and red wordle clues on"
        } else if gameMode == "Pro" {
            modeDescription.text = "Pro description - no wordle clues on"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        emailSaved = rememberEmail.text ?? ""
    }
    
    @IBAction func timeSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            showTime = true
        } else {
            showTime = false
        }
        timeSwitch.setOn(showTime, animated: true)
    }
    
    
    @IBAction func triesSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            showTries = true
        } else {
            showTries = false
        }
        triesSwitch.setOn(showTries, animated: true)
    }

}
