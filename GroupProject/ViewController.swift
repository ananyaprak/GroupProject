//
//  ViewController.swift
//  GroupProject
//
//  Created by AAAVPrakash12 on 10/6/22.
//

// TODO: add core data :(

import UIKit

class ViewController: UIViewController {
    
    // TODO: add crossword letter labels
    var delegate: UIViewController!
    var puzzleIndex:Int = 0
    @IBOutlet weak var puzzleImage: UIImageView!
    @IBOutlet weak var totalTries: UILabel!
    @IBOutlet weak var wordTries: UILabel!
    @IBOutlet weak var wordSelected: UILabel!
    @IBOutlet weak var wordBlanks: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
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
    var cluesCompleted = [String]()
    var button:String = ""
    
    let queue = DispatchQueue(label: "queue")
    let mainQueue = DispatchQueue.main
    var timerOn = false
    
    let start = DispatchTime.now()
    var current = DispatchTime(uptimeNanoseconds: 0)
    var seconds = 0
    var time = (0, 0, 0)
    var oldTime = (0, 0, 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = puzzleList[puzzleIndex].title
        puzzleImage.image = puzzleList[puzzleIndex].image
        
        if puzzleImage.image == UIImage(named: "crossword1") {

        } else if puzzleImage.image == UIImage(named: "crossword2") {

        }
        
        totalTries.text = "Total Tries: \(puzzleList[puzzleIndex].totalTries)"
        wordTries.text = ""
        wordSelected.text = ""
        wordBlanks.text = ""
        
        clueButtons(isAcross: true)
        clueButtons(isAcross: false)
        
        current = DispatchTime(uptimeNanoseconds: puzzleList[puzzleIndex].elapsedTime)
        if puzzleList[puzzleIndex].status != "Completed" {
            timerOn = true
        }
        nanoToSeconds(nanoTime: puzzleList[puzzleIndex].elapsedTime)
        oldTime = convertSeconds(seconds: seconds)
        runBackground()
    }
    
    override func  viewWillDisappear(_ animated: Bool) {
        timerOn = false
        let otherVC = delegate as! UpdateTable
        otherVC.reloadTable()
    }
    
    func runMain(seconds:Int, duration:UInt64) {
            mainQueue.async {
                self.time = self.convertSeconds(seconds:self.seconds)
                let timeText = "\(self.time.0 + self.oldTime.0):\(self.time.1 + self.oldTime.1):\(self.time.2 + self.oldTime.2)"
                self.durationLabel.text = "Elapsed Time: \(timeText)"
                puzzleList[self.puzzleIndex].elapsedTime = duration
                puzzleList[self.puzzleIndex].fancyTime = timeText
            }
    }
    
    func runBackground() {
        queue.async {
            while(self.timerOn == true) {
                let end = DispatchTime.now()

                let nanoTime = end.uptimeNanoseconds - self.start.uptimeNanoseconds
                let timeInterval = Double(nanoTime) / 1_000_000_000

                self.seconds = Int(round(timeInterval))
                self.runMain(seconds:self.seconds, duration:(nanoTime + self.current.uptimeNanoseconds))
                
                sleep(1)
            }
        }
    }
    
    func nanoToSeconds(nanoTime:UInt64) {
        let timeInterval = Double(nanoTime) / 1_000_000_000
        seconds = Int(round(timeInterval))
    }
    
    func convertSeconds(seconds:Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func clueButtons(isAcross:Bool) {
        var directionList:Array<UIButton>
        var puzzleDirectionList:Array<Word>
        if isAcross {
            directionList = [across5, across4, across3, across2, across1]
            puzzleDirectionList = puzzleList[puzzleIndex].acrossList
        } else {
            directionList = [down5, down4, down3, down2, down1]
            puzzleDirectionList = puzzleList[puzzleIndex].downList
        }
        
        let nonIncluded = (numButtons - 1) - puzzleDirectionList.count
        for i in 0...4 {
            if i <= nonIncluded {
                directionList[i].isHidden = true
            } else {
                directionList[i].setTitle(String(puzzleDirectionList[((numButtons - 1) - i)].clueNum), for: .normal)
            }
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        var clueType:String
        if sender.tag < 5 {
            clueType = "Across"
        } else {
            clueType = "Down"
        }
        button = sender.titleLabel!.text! + " " + clueType
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
        var currentLetter = 0
        for letter in wordComponents {
            if currentWord?.knownLetters[currentLetter] == true {
                wordSeparated += "\(letter) "
            } else {
                wordSeparated += "_ "
            }
            currentLetter += 1
        }
        wordBlanks.text = String(wordSeparated.dropLast())
        
        if cluesCompleted.contains(button) {
            guessField.isUserInteractionEnabled = false
        } else {
            guessField.isUserInteractionEnabled = true
        }
    }
    
    func incrementTries(correct:Bool) {
        puzzleList[puzzleIndex].totalTries += 1
        totalTries.text = "Total Tries: \(puzzleList[puzzleIndex].totalTries)"
        
        currentWord?.tries += 1
        if correct {
            wordTries.text = "Correct! Tries: \(currentWord!.tries)"
        } else {
            wordTries.text = "Tries: \(currentWord!.tries)"
        }
        
    }
    
    @IBAction func guessPressed(_ sender: Any) {
        // TODO: add wordle clues
        if currentWord != nil {
            if guessField.text!.count == 0 {
                wordTries.text = "Don't forget to guess!"
            } else if guessField.text!.count != currentWord!.name.count {
                wordTries.text = "Invalid - check number of letters"
            } else if guessField.text != currentWord?.name {
                incrementTries(correct: false)
            } else if guessField.text == currentWord?.name {
                incrementTries(correct: true)
                currentButton?.tintColor = .gray
                guessField.text = ""
                currentWord = nil
                wordSelected.text = ""
                wordBlanks.text = ""
                wordTries.text = ""
                cluesCompleted.append(button)
                button = ""

            }
        } else {
            wordTries.text = "Choose a clue first"
        }
    }
    
    
    
    

    // ananya test!
    // zach test

}

