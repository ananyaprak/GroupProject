//
//  ViewController.swift
//  GroupProject
//
//  Created by AAAVPrakash12 on 10/6/22.
//

import UIKit

class ViewController: UIViewController {
    
    var delegate: UIViewController!
    var puzzleIndex:Int = 0
    @IBOutlet weak var puzzleImage: UIImageView!
    @IBOutlet weak var totalTries: UILabel!
    @IBOutlet weak var wordTries: UILabel!
    @IBOutlet weak var wordSelected: UILabel!
    @IBOutlet weak var wordBlanks: UILabel!
    
    let numButtons = 5
    @IBOutlet weak var across1: UIButton!
    @IBOutlet weak var across2: UIButton!
    @IBOutlet weak var across3: UIButton!
    @IBOutlet weak var across4: UIButton!
    @IBOutlet weak var across5: UIButton!
    @IBOutlet weak var down1: UIButton!
    @IBOutlet weak var down2: UIButton!
    @IBOutlet weak var down3: UIButton!
    @IBOutlet weak var down4: UIButton!
    @IBOutlet weak var down5: UIButton!
    
    var currentWord:Word?
    @IBOutlet weak var guessField: UITextField!
    var currentButton:UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        puzzleImage.image = puzzleList[puzzleIndex].image
        totalTries.text = "Total Tries: \(puzzleList[puzzleIndex].totalTries)"
        wordTries.text = ""
        wordSelected.text = ""
        wordBlanks.text = ""
        
        let acrossList = [across5, across4, across3, across2, across1]
        let nonAcross = (numButtons - 1) - puzzleList[puzzleIndex].acrossList.count
        for i in 0...4 {
            if i <= nonAcross {
                acrossList[i]?.isHidden = true
            } else {
                acrossList[i]?.setTitle(String(puzzleList[puzzleIndex].acrossList[((numButtons - 1) - i)].clueNum), for: .normal)
            }
        }
        let downList = [down5, down4, down3, down2, down1]
        let nonDown = (numButtons - 1) - puzzleList[puzzleIndex].downList.count
        for i in 0...4 {
            if i <= nonDown {
                downList[i]?.isHidden = true
            } else {
                downList[i]?.setTitle(String(puzzleList[puzzleIndex].downList[((numButtons - 1) - i)].clueNum), for: .normal)
            }
        }
        
        print(puzzleList[puzzleIndex].acrossList)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        var clueType:String
        if sender.tag < 5 {
            clueType = "Across"
        } else {
            clueType = "Down"
        }
        let button = sender.titleLabel!.text! + " " + clueType
        wordSelected.text = "Selected: \(button)"
        
        currentButton = sender
        
        var word = ""
        if clueType == "Across" {
            for clue in puzzleList[puzzleIndex].acrossList {
                if button == clue.tag {
                    word = clue.name
                    wordTries.text = "Tries: " + String(clue.tries)
                    currentWord = clue
                }
            }
        } else if clueType == "Down" {
            for clue in puzzleList[puzzleIndex].downList {
                if button == clue.tag {
                    word = clue.name
                    wordTries.text = "Tries: " + String(clue.tries)
                    currentWord = clue
                }
            }
        }
        let wordComponents = Array(word)
        var wordSeparated = ""
        for _ in wordComponents {
            wordSeparated += "_ "
        }
        wordBlanks.text = String(wordSeparated.dropLast())
    }
    
    @IBAction func guessPressed(_ sender: Any) {
        if currentWord != nil {
            if guessField.text!.count == 0 {
                wordTries.text = "Don't forget to guess!"
            } else if guessField.text!.count != currentWord!.name.count {
                wordTries.text = "Invalid - check number of letters"
            } else if guessField.text != currentWord?.name {
                currentWord?.tries += 1
                wordTries.text = "Tries: \(currentWord!.tries)"
                puzzleList[puzzleIndex].totalTries += 1
                totalTries.text = "Total Tries: \(puzzleList[puzzleIndex].totalTries)"
            } else if guessField.text == currentWord?.name {
                currentWord?.tries += 1
                wordTries.text = "Correct! Tries: \(currentWord!.tries)"
                puzzleList[puzzleIndex].totalTries += 1
                totalTries.text = "Total Tries: \(puzzleList[puzzleIndex].totalTries)"
                currentButton?.isHidden = true
            }
        } else {
            wordTries.text = "Choose a clue first"
        }
    }
    
    
    
    

    // ananya test!
    // zach test

}

