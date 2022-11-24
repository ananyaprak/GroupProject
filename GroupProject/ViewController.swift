//
//  ViewController.swift
//  GroupProject
//
//  Created by AAAVPrakash12 on 10/6/22.
//

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
    
    @IBOutlet weak var cwLabel0: UILabel!
    @IBOutlet weak var cwLabel1: UILabel!
    @IBOutlet weak var cwLabel2: UILabel!
    @IBOutlet weak var cwLabel3: UILabel!
    @IBOutlet weak var cwLabel4: UILabel!
    @IBOutlet weak var cwLabel5: UILabel!
    @IBOutlet weak var cwLabel6: UILabel!
    @IBOutlet weak var cwLabel7: UILabel!
    @IBOutlet weak var cwLabel8: UILabel!
    @IBOutlet weak var cwLabel9: UILabel!
    @IBOutlet weak var cwLabel10: UILabel!
    @IBOutlet weak var cwLabel11: UILabel!
    @IBOutlet weak var cwLabel12: UILabel!
    @IBOutlet weak var cwLabel13: UILabel!
    @IBOutlet weak var cwLabel14: UILabel!
    @IBOutlet weak var cwLabel15: UILabel!
    @IBOutlet weak var cwLabel16: UILabel!
    @IBOutlet weak var cwLabel17: UILabel!
    @IBOutlet weak var cwLabel18: UILabel!
    @IBOutlet weak var cwLabel19: UILabel!
    @IBOutlet weak var cwLabel20: UILabel!
    @IBOutlet weak var cwLabel21: UILabel!
    @IBOutlet weak var cwLabel22: UILabel!
    @IBOutlet weak var cwLabel23: UILabel!
    @IBOutlet weak var cwLabel24: UILabel!
    @IBOutlet weak var cwLabel25: UILabel!
    @IBOutlet weak var cwLabel26: UILabel!
    @IBOutlet weak var cwLabel27: UILabel!
    @IBOutlet weak var cwLabel28: UILabel!
    @IBOutlet weak var cwLabel29: UILabel!
    @IBOutlet weak var cwLabel30: UILabel!
    @IBOutlet weak var cwLabel31: UILabel!
    @IBOutlet weak var cwLabel32: UILabel!
    @IBOutlet weak var cwLabel33: UILabel!
    
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
        
        let _ = [cwLabel0, cwLabel1, cwLabel2, cwLabel3, cwLabel4, cwLabel5, cwLabel6, cwLabel7, cwLabel8, cwLabel9, cwLabel10, cwLabel11, cwLabel12, cwLabel13, cwLabel14, cwLabel15, cwLabel16, cwLabel17, cwLabel18, cwLabel19, cwLabel20, cwLabel21, cwLabel22, cwLabel23, cwLabel24, cwLabel25, cwLabel26, cwLabel27, cwLabel28, cwLabel29, cwLabel30, cwLabel31, cwLabel32, cwLabel33]
        if puzzleImage.image == UIImage(named: "crossword1") {
            for word in puzzleList[puzzleIndex!].acrossList {
                if word.clueNum == 3 {
                    word.wordLetters[0].assignBox(box: cwLabel4)
                    word.wordLetters[1].assignBox(box: cwLabel5)
                    word.wordLetters[2].assignBox(box: cwLabel6)
                    word.wordLetters[3].assignBox(box: cwLabel7)
                } else if word.clueNum == 4 {
                    word.wordLetters[0].assignBox(box: cwLabel11)
                    word.wordLetters[1].assignBox(box: cwLabel12)
                    word.wordLetters[2].assignBox(box: cwLabel13)
                    word.wordLetters[3].assignBox(box: cwLabel14)
                    word.wordLetters[4].assignBox(box: cwLabel15)
                    word.wordLetters[5].assignBox(box: cwLabel16)
                    word.wordLetters[6].assignBox(box: cwLabel17)
                    word.wordLetters[7].assignBox(box: cwLabel18)
                    word.wordLetters[8].assignBox(box: cwLabel19)
                } else if word.clueNum == 5 {
                    word.wordLetters[0].assignBox(box: cwLabel22)
                    word.wordLetters[1].assignBox(box: cwLabel23)
                    word.wordLetters[2].assignBox(box: cwLabel24)
                    word.wordLetters[3].assignBox(box: cwLabel25)
                    word.wordLetters[4].assignBox(box: cwLabel26)
                    word.wordLetters[5].assignBox(box: cwLabel27)
                    word.wordLetters[6].assignBox(box: cwLabel28)
                    word.wordLetters[7].assignBox(box: cwLabel29)
                }
                
                for letter in word.wordLetters {
                    if letter.known {
                        letter.cwBox!.text = String(letter.letter)
                    } else {
                        letter.cwBox!.text = ""
                    }
                }
            }
            for word in puzzleList[puzzleIndex!].downList {
                if word.clueNum == 1 {
                    word.wordLetters[0].assignBox(box: cwLabel0)
                    word.wordLetters[1].assignBox(box: cwLabel1)
                    word.wordLetters[2].assignBox(box: cwLabel3)
                    word.wordLetters[3].assignBox(box: cwLabel8)
                    word.wordLetters[4].assignBox(box: cwLabel10)
                    word.wordLetters[5].assignBox(box: cwLabel17)
                } else if word.clueNum == 2 {
                    word.wordLetters[0].assignBox(box: cwLabel2)
                    word.wordLetters[1].assignBox(box: cwLabel7)
                    word.wordLetters[2].assignBox(box: cwLabel9)
                    word.wordLetters[3].assignBox(box: cwLabel13)
                    word.wordLetters[4].assignBox(box: cwLabel20)
                    word.wordLetters[5].assignBox(box: cwLabel21)
                    word.wordLetters[6].assignBox(box: cwLabel23)
                } else if word.clueNum == 6 {
                    word.wordLetters[0].assignBox(box: cwLabel25)
                    word.wordLetters[1].assignBox(box: cwLabel30)
                    word.wordLetters[2].assignBox(box: cwLabel31)
                    word.wordLetters[3].assignBox(box: cwLabel32)
                    word.wordLetters[4].assignBox(box: cwLabel33)
                }
                
                for letter in word.wordLetters {
                    if letter.known {
                        letter.cwBox!.text = String(letter.letter)
                    } else {
                        letter.cwBox!.text = ""
                    }
                }
            }
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
            letter.cwBox!.text = String(letter.letter)
            if letter.crossingLetter != nil {
                letter.crossingLetter?.known = true
                letter.crossingLetter?.cwBox!.text = String(letter.letter)
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
                            currentWord!.wordLetters[guessedLetterInd].cwBox!.text = String(currentWord!.wordLetters[guessedLetterInd].letter)
                            if currentWord!.wordLetters[guessedLetterInd].crossingLetter != nil {
                                currentWord!.wordLetters[guessedLetterInd].crossingLetter?.known = true
                                currentWord!.wordLetters[guessedLetterInd].crossingLetter?.cwBox!.text = String(currentWord!.wordLetters[guessedLetterInd].letter)
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

