//
//  ViewController.swift
//  GroupProject
//
//  Created by AAAVPrakash12 on 10/6/22.
//

// TODO: add core data :(

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var puzzleImage: UIImageView!
    @IBOutlet weak var totalTries: UILabel!
    @IBOutlet weak var wordTries: UILabel!
    @IBOutlet weak var wordSelected: UILabel!
    @IBOutlet weak var wordBlanks: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var guessButton: UIButton!
    
    
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
    var button:String = ""
    
    @IBOutlet weak var currentYellows: UILabel!
    @IBOutlet weak var currentReds: UILabel!
    
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
        title = puzzleList[puzzleIndex!].title
        puzzleImage.image = puzzleList[puzzleIndex!].image
        
        if puzzleImage.image == UIImage(named: "crossword1") {
            // TODO: add crossword letter labels, connect to clues
        }
        
        totalTries.text = "Total Tries: \(puzzleList[puzzleIndex!].totalTries)"
        wordTries.text = ""
        wordSelected.text = ""
        wordBlanks.text = ""
        currentYellows.text = ""
        currentReds.text = ""
        
        clueButtons(isAcross: true)
        clueButtons(isAcross: false)
        
        current = DispatchTime(uptimeNanoseconds: puzzleList[puzzleIndex!].elapsedTime)
        if puzzleList[puzzleIndex!].status != "Completed" {
            timerOn = true
            
        } else {
            durationLabel.text = "Elapsed Time: \(puzzleList[puzzleIndex!].fancyTime)"
        }
        nanoToSeconds(nanoTime: puzzleList[puzzleIndex!].elapsedTime)
        oldTime = convertSeconds(seconds: seconds)
        runBackground()
        
    }
    
    override func  viewWillDisappear(_ animated: Bool) {
        timerOn = false
    }
    
    func runMain(seconds:Int, duration:UInt64) {
            mainQueue.async {
                self.time = self.convertSeconds(seconds:self.seconds)
                
                var time0 = ""
                var time1 = ""
                var time2 = ""
                if self.time.0 + self.oldTime.0 < 10 {
                    time0 = String(0) + String(self.time.0 + self.oldTime.0)
                } else {
                    time0 = String(self.time.0 + self.oldTime.0)
                }
                if self.time.1 + self.oldTime.1 < 10 {
                    time1 = String(0) + String(self.time.1 + self.oldTime.1)
                } else {
                    time1 = String(self.time.1 + self.oldTime.1)
                }
                if self.time.2 + self.oldTime.2 < 10 {
                    time2 = String(0) + String(self.time.2 + self.oldTime.2)
                } else {
                    time2 = String(self.time.2 + self.oldTime.2)
                }
                
                let timeText = "\(time0):\(time1):\(time2)"
                self.durationLabel.text = "Elapsed Time: \(timeText)"
                puzzleList[puzzleIndex!].elapsedTime = duration
                puzzleList[puzzleIndex!].fancyTime = timeText
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
        var direction:String
        if isAcross {
            directionList = [across5, across4, across3, across2, across1]
            puzzleDirectionList = puzzleList[puzzleIndex!].acrossList
            direction = " Across"
        } else {
            directionList = [down5, down4, down3, down2, down1]
            puzzleDirectionList = puzzleList[puzzleIndex!].downList
            direction = " Down"
        }
        
        let nonIncluded = (numButtons - 1) - puzzleDirectionList.count
        for i in 0...4 {
            if i <= nonIncluded {
                directionList[i].isHidden = true
            } else {
                let buttonNum = String(puzzleDirectionList[((numButtons - 1) - i)].clueNum)
                directionList[i].setTitle(buttonNum, for: .normal)
                if puzzleList[puzzleIndex!].cluesCompleted.contains(buttonNum + direction) {
                    directionList[i].tintColor = .gray
                }
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
            for clue in puzzleList[puzzleIndex!].acrossList {
                if button == clue.tag {
                    word = clue.name
                    wordTries.text = "Tries: " + String(clue.tries)
                    currentWord = clue
                }
            }
        } else if clueType == "Down" {
            for clue in puzzleList[puzzleIndex!].downList {
                if button == clue.tag {
                    word = clue.name
                    wordTries.text = "Tries: " + String(clue.tries)
                    currentWord = clue
                }
            }
        }
        
        updateBlanks(word:word)
        
        if puzzleList[puzzleIndex!].cluesCompleted.contains(button) {
            guessField.isUserInteractionEnabled = false
            guessField.text = word
            guessButton.isUserInteractionEnabled = false
            
        } else {
            guessField.isUserInteractionEnabled = true
            guessField.text = ""
            guessButton.isUserInteractionEnabled = true
        }
        
        if gameMode != "Pro" {
            currentYellows.text = ""
            for letter in currentWord!.yellowLetters {
                currentYellows.text! += String(letter) + " "
            }
            currentReds.text = ""
            for letter in currentWord!.redLetters {
                currentReds.text! += String(letter) + " "
            }
        }
    }
    
    func updateBlanks(word:String) {
        let wordComponents = Array(word)
        var wordSeparated = ""
        var currentLetter = 0
        for letter in wordComponents {
            if currentWord?.wordLetters[currentLetter].known == true && gameMode == "Noob" {
                wordSeparated += "\(letter) "
            } else {
                wordSeparated += "_ "
            }
            currentLetter += 1
        }
        wordBlanks.text = String(wordSeparated.dropLast())
    }
    
    func incrementTries(correct:Bool) {
        puzzleList[puzzleIndex!].totalTries += 1
        totalTries.text = "Total Tries: \(puzzleList[puzzleIndex!].totalTries)"
        
        currentWord?.tries += 1
        if correct {
            wordTries.text = "Correct! Tries: \(currentWord!.tries)"
        } else {
            wordTries.text = "Tries: \(currentWord!.tries)"
        }
        
    }
    
    func wordGuessed() {
        incrementTries(correct: true)
        currentButton?.tintColor = .gray
        guessField.text = ""
        wordSelected.text = ""
        wordTries.text = "Correct!"
        puzzleList[puzzleIndex!].cluesCompleted.append(button)
        button = ""
        currentYellows.text = ""
        currentReds.text = ""
        if puzzleList[puzzleIndex!].cluesCompleted.count == 6 {
            timerOn = false
            puzzleList[puzzleIndex!].changeStatus(value: 2)
            var msg = ""
            if puzzleIndex! == (puzzleList.count - 1) {
                msg = "You've completed all available puzzles :o"
            } else {
                puzzleList[puzzleIndex! + 1].changeStatus(value: 1)
                msg = "You've unlocked the next puzzle :)"
            }
            let controller = UIAlertController(
                title: "Puzzle Completed!",
                message: msg,
                preferredStyle: .alert)
            controller.addAction(UIAlertAction(
                title: "woohoo",
                style: .default))
            present(controller, animated:true)
        }
        for letter in currentWord!.wordLetters {
            letter.known = true
            if letter.crossingLetter != nil {
                letter.crossingLetter?.known = true
            }
        }
        updateBlanks(word: currentWord!.name)
        wordBlanks.text = ""
        currentWord = nil
    }
    
    @IBAction func guessPressed(_ sender: Any) {
        if currentWord != nil {
            if guessField.text!.count == 0 {
                wordTries.text = "Don't forget to guess!"
            } else if guessField.text!.count != currentWord!.name.count {
                wordTries.text = "Invalid - check number of letters"
            } else if guessField.text != currentWord!.name {
                incrementTries(correct: false)
                let guessedWord = Array(guessField.text!)
                let clueLetters = Array(currentWord!.name)
                for guessedLetterInd in 0...(guessedWord.count-1) {
                    if clueLetters.contains(guessedWord[guessedLetterInd]) && !currentWord!.yellowLetters.contains(guessedWord[guessedLetterInd]) {
                        
                        if clueLetters[guessedLetterInd] == guessedWord[guessedLetterInd] {
                            currentWord!.wordLetters[guessedLetterInd].known = true
                            if currentWord!.wordLetters[guessedLetterInd].crossingLetter != nil {
                                currentWord!.wordLetters[guessedLetterInd].crossingLetter?.known = true
                            }
                        } else {
                            currentWord!.yellowLetters.append(guessedWord[guessedLetterInd])
                            if gameMode != "Pro" {
                                currentYellows.text! += String(guessedWord[guessedLetterInd]) + " "
                            }
                        }
                        
                    } else if !currentWord!.redLetters.contains(guessedWord[guessedLetterInd]) && !currentWord!.yellowLetters.contains(guessedWord[guessedLetterInd]) {
                        currentWord!.redLetters.append(guessedWord[guessedLetterInd])
                        if gameMode != "Pro" {
                            currentReds.text! += String(guessedWord[guessedLetterInd]) + " "
                        }
                    }
                    
                    updateBlanks(word:currentWord!.name)
                }
            } else if guessField.text == currentWord?.name {
                wordGuessed()
            }
        } else {
            wordTries.text = "Choose a clue first"
        }
    }

}

