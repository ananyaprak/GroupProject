//
//  ViewController.swift
//  GroupProject
//
//  Created by AAAVPrakash12 on 10/6/22.
//

import UIKit

class ViewController: UIViewController {
    
    // for when constraints or other puzzles are added in future
    let constraints = false
    
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
    
    var labelList = [UILabel]()
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
    
    var currentWord:WordClass?
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
    var timeText = ""
    var endTime = ""
    
    var currentCluesCompleted = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = bgColor
        
        title = puzzleList[puzzleIndex!].title
        puzzleImage.image = puzzleList[puzzleIndex!].image
        
        if let attrFont = UIFont(name: "Noteworthy", size: 17) {
            let title = "Guess"
            let attrTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: attrFont])
            guessButton.setAttributedTitle(attrTitle, for: UIControl.State.normal)
        }
        
        across1.layer.borderWidth = 1
        across1.layer.cornerRadius = 10
        across1.layer.borderColor = UIColor.black.cgColor
        across2.layer.borderWidth = 1
        across2.layer.cornerRadius = 10
        across2.layer.borderColor = UIColor.black.cgColor
        across3.layer.borderWidth = 1
        across3.layer.cornerRadius = 10
        across3.layer.borderColor = UIColor.black.cgColor
        down1.layer.borderWidth = 1
        down1.layer.cornerRadius = 10
        down1.layer.borderColor = UIColor.black.cgColor
        down2.layer.borderWidth = 1
        down2.layer.cornerRadius = 10
        down2.layer.borderColor = UIColor.black.cgColor
        down3.layer.borderWidth = 1
        down3.layer.cornerRadius = 10
        down3.layer.borderColor = UIColor.black.cgColor
        
        labelList = [cwLabel0, cwLabel1, cwLabel2, cwLabel3, cwLabel4, cwLabel5, cwLabel6, cwLabel7, cwLabel8, cwLabel9, cwLabel10, cwLabel11, cwLabel12, cwLabel13, cwLabel14, cwLabel15, cwLabel16, cwLabel17, cwLabel18, cwLabel19, cwLabel20, cwLabel21, cwLabel22, cwLabel23, cwLabel24, cwLabel25, cwLabel26, cwLabel27, cwLabel28, cwLabel29, cwLabel30, cwLabel31, cwLabel32, cwLabel33]
        
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
                    if letter.known && currentUser?.value(forKey: "gameMode") as! String == "Noob" {
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
                    if letter.known && currentUser?.value(forKey: "gameMode") as! String == "Noob" {
                        letter.cwBox!.text = String(letter.letter)
                    } else {
                        letter.cwBox!.text = ""
                    }
                }
            }
            
        }
        
        var triesRN = ""
        if puzzleCoreData {
            currentCluesCompleted = corePuzzles[puzzleIndex!].value(forKey: "cluesCompleted") as! [String]
            let tempTries = corePuzzles[puzzleIndex!].value(forKey: "totalTries") as! UInt16
            triesRN = String(tempTries)
        } else {
            currentCluesCompleted = puzzleList[puzzleIndex!].cluesCompleted
            triesRN = String(puzzleList[puzzleIndex!].totalTries)
        }
        
        totalTries.text = "Total Tries: \(triesRN)"
        wordTries.text = ""
        wordSelected.text = ""
        wordBlanks.text = ""
        currentYellows.text = ""
        currentReds.text = ""
        
        clueButtons(isAcross: true)
        clueButtons(isAcross: false)
        
        var statusRN = ""
        var fancyRN = ""
        var elapsedRN:UInt64
        if puzzleCoreData {
            current = DispatchTime(uptimeNanoseconds: corePuzzles[puzzleIndex!].value(forKey: "elapsedTime") as! UInt64)
            statusRN = corePuzzles[puzzleIndex!].value(forKey: "status") as! String
            fancyRN = corePuzzles[puzzleIndex!].value(forKey: "fancyTime") as! String
            elapsedRN = corePuzzles[puzzleIndex!].value(forKey: "elapsedTime") as! UInt64
        } else {
            current = DispatchTime(uptimeNanoseconds: puzzleList[puzzleIndex!].elapsedTime)
            statusRN = puzzleList[puzzleIndex!].status
            fancyRN = puzzleList[puzzleIndex!].fancyTime
            elapsedRN = puzzleList[puzzleIndex!].elapsedTime
        }
        if statusRN != "Completed" {
            timerOn = true
            
        } else {
            durationLabel.text = "Elapsed Time: \(fancyRN)"
        }
        nanoToSeconds(nanoTime: elapsedRN)
        oldTime = convertSeconds(seconds: seconds)
        runBackground()
        
    }
    
    override func viewDidLayoutSubviews() {
        if constraints {
            placeLabels()
            var lstW = [CGFloat]()
            var lstH = [CGFloat]()
            for labelNum in 0...(labelList.count-1) {
                print("\(labelNum): \(labelList[labelNum].frame.midX), \(labelList[labelNum].frame.midY)")
                lstW.append(labelList[labelNum].frame.width)
                lstH.append(labelList[labelNum].frame.height)
            }
            print(view.frame.size)
            print(puzzleImage.frame.size)
            let sumW = lstW.reduce(0, +)
            let avgW = sumW / CGFloat(lstW.count)
            print(avgW)
            let sumH = lstH.reduce(0, +)
            let avgH = sumH / CGFloat(lstH.count)
            print(avgH)
        }
    }
    
    override func  viewWillDisappear(_ animated: Bool) {
        timerOn = false
        if puzzleCoreData {
            corePuzzles[puzzleIndex!].setValue(currentCluesCompleted, forKey: "cluesCompleted")
            saveContext()
        } else {
            puzzleList[puzzleIndex!].cluesCompleted = currentCluesCompleted
        }
    }
    
    func placeLabels() {
        var down1Labels = [UILabel]()
        var down1x = CGFloat(0)
        var down2Labels = [UILabel]()
        var down2x = CGFloat(0)
        let down3Labels = [UILabel]()
        let down3x = CGFloat(0)
        let down4Labels = [UILabel]()
        let down4x = CGFloat(0)
        let down5Labels = [UILabel]()
        let down5x = CGFloat(0)
        var down6Labels = [UILabel]()
        var down6x = CGFloat(0)
        let across1Labels = [UILabel]()
        let across1y = CGFloat(0)
        let across2Labels = [UILabel]()
        let across2y = CGFloat(0)
        var across3Labels = [UILabel]()
        var across3y = CGFloat(0)
        var across4Labels = [UILabel]()
        var across4y = CGFloat(0)
        var across5Labels = [UILabel]()
        var across5y = CGFloat(0)
        let across6Labels = [UILabel]()
        let across6y = CGFloat(0)
        let lists = [down1Labels, down2Labels, down3Labels, down4Labels, down5Labels, down6Labels, across1Labels, across2Labels, across3Labels, across4Labels, across5Labels, across6Labels]
        let coords = [down1x, down2x, down3x, down4x, down5x, down6x, across1y, across2y, across3y, across4y, across5y, across6y]
        var changeY = CGFloat(0)
        var changeX = CGFloat(0)
        if puzzleImage.image == UIImage(named: "crossword1") {
            down1Labels = [cwLabel0, cwLabel1, cwLabel3, cwLabel8, cwLabel10, cwLabel17]
            down1x = 285.5
            down1Labels[0].center.y = 158.5
            down2Labels = [cwLabel2, cwLabel7, cwLabel9, cwLabel13, cwLabel20, cwLabel21, cwLabel23]
            down2x = 172.0
            down6Labels = [cwLabel25, cwLabel30, cwLabel31, cwLabel32, cwLabel33]
            down6x = 229.0
            across3Labels = [cwLabel4, cwLabel5, cwLabel6, cwLabel7]
            across3y = 226.5
            across4Labels = [cwLabel11, cwLabel12, cwLabel13, cwLabel14, cwLabel15, cwLabel16, cwLabel17, cwLabel18, cwLabel19]
            across4y = 282.0
            across5Labels = [cwLabel22, cwLabel23, cwLabel24, cwLabel25, cwLabel26, cwLabel27, cwLabel28, cwLabel29]
            across5y = 366.0
            changeY = 27.5
            changeX = 34.0
        }
        for listNum in 0...(lists.count-1) {
            if listNum < 6 && !lists[listNum].isEmpty {
                for labelNum in 0...(lists[listNum].count-1) {
                    lists[listNum][labelNum].center.x = coords[listNum]
                    if labelNum != 0 {
                        lists[listNum][labelNum].center.y = lists[listNum][labelNum-1].center.y - changeY
                    }
                }
            } else if !lists[listNum].isEmpty {
                for labelNum in 0...(lists[listNum].count-1) {
                    lists[listNum][labelNum].center.y = coords[listNum]
                    if labelNum != 0 {
                        lists[listNum][labelNum].center.x = lists[listNum][labelNum-1].center.x - changeX
                    }
                }
            }
        }
    }
    
    func makeFancyTime(seconds:Int, end:Bool) {
        time = convertSeconds(seconds: seconds)
        
        var time0 = ""
        var time1 = ""
        var time2 = ""
        
        if end {
            if time.0 < 10 {
                time0 = String(0) + String(time.0)
            } else {
                time0 = String(time.0)
            }
            if time.1 < 10 {
                time1 = String(0) + String(time.1)
            } else {
                time1 = String(time.1)
            }
            if time.2 < 10 {
                time2 = String(0) + String(time.2)
            } else {
                time2 = String(time.2)
            }
            
            endTime = "\(time0):\(time1):\(time2)"
        } else {
            if time.0 + oldTime.0 < 10 {
                time0 = String(0) + String(time.0 + oldTime.0)
            } else {
                time0 = String(time.0 + oldTime.0)
            }
            if time.1 + oldTime.1 < 10 {
                time1 = String(0) + String(time.1 + oldTime.1)
            } else {
                time1 = String(time.1 + oldTime.1)
            }
            if time.2 + oldTime.2 < 10 {
                time2 = String(0) + String(time.2 + oldTime.2)
            } else {
                time2 = String(time.2 + oldTime.2)
            }
            
            timeText = "\(time0):\(time1):\(time2)"
        }
    }
    
    func runMain(seconds:Int, duration:UInt64) {
            mainQueue.async {
                self.makeFancyTime(seconds: seconds, end: false)
                self.durationLabel.text = "Elapsed Time: \(self.timeText)"
                
                if puzzleCoreData {
                    corePuzzles[puzzleIndex!].setValue(duration, forKey: "elapsedTime")
                    corePuzzles[puzzleIndex!].setValue(self.timeText, forKey: "fancyTime")
                    self.saveContext()
                } else {
                    puzzleList[puzzleIndex!].elapsedTime = duration
                    puzzleList[puzzleIndex!].fancyTime = self.timeText
                }
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
        var puzzleDirectionList:Array<WordClass>
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
                if let attrFont = UIFont(name: "Noteworthy", size: 17) {
                    let title = buttonNum
                    let attrTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: attrFont])
                    directionList[i].setAttributedTitle(attrTitle, for: UIControl.State.normal)
                }
                if currentCluesCompleted.contains(buttonNum + direction) {
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
        
        if currentCluesCompleted.contains(button) {
            guessField.isUserInteractionEnabled = false
            guessField.text = word
            guessButton.isUserInteractionEnabled = false
            
        } else {
            guessField.isUserInteractionEnabled = true
            guessField.text = ""
            guessButton.isUserInteractionEnabled = true
        }
        
        if currentUser?.value(forKey: "gameMode") as! String != "Pro" {
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
            if currentWord?.wordLetters[currentLetter].known == true && (currentUser?.value(forKey: "gameMode") as! String == "Noob" || currentCluesCompleted.contains(button) || currentWord!.wordLetters[currentLetter].crossingLetter?.known == true) {
                wordSeparated += "\(letter) "
            } else {
                wordSeparated += "_ "
            }
            currentLetter += 1
        }
        wordBlanks.text = String(wordSeparated.dropLast())
    }
    
    func incrementTries(correct:Bool) {
        if puzzleCoreData {
            var currentTotalTries = corePuzzles[puzzleIndex!].value(forKey: "totalTries") as! Int
            currentTotalTries += 1
            corePuzzles[puzzleIndex!].setValue(currentTotalTries, forKey: "totalTries")
            saveContext()
            totalTries.text = "Total Tries: \(corePuzzles[puzzleIndex!].value(forKey: "totalTries") ?? "totalTries error")"
        } else {
            puzzleList[puzzleIndex!].totalTries += 1
            totalTries.text = "Total Tries: \(puzzleList[puzzleIndex!].totalTries)"
        }
        
        
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
        currentCluesCompleted.append(button)
        button = ""
        currentYellows.text = ""
        currentReds.text = ""
        if currentCluesCompleted.count == 6 {
            timerOn = false
            puzzleList[puzzleIndex!].changeStatus(value: 2)
            if puzzleCoreData {
                // minitodo: put this in puzzle class function
                corePuzzles[puzzleIndex!].setValue("Completed", forKey: "status")
            }
            var msg = ""
            if puzzleIndex! == (puzzleList.count - 1) {
                msg = "You've completed all available puzzles :o"
                
                let curNoobTries: Int = currentUser?.value(forKey: "noobTries") as! Int
                let curGamerTries: Int = currentUser?.value(forKey: "gamerTries") as! Int
                let curProTries: Int = currentUser?.value(forKey: "proTries") as! Int
                let allThreeTries = puzzleList[0].totalTries + puzzleList[1].totalTries + puzzleList[2].totalTries
                
                let curNoobTime: UInt64 = currentUser?.value(forKey: "noobTime") as! UInt64
                let curGamerTime: UInt64 = currentUser?.value(forKey: "gamerTime") as! UInt64
                let curProTime: UInt64 = currentUser?.value(forKey: "proTime") as! UInt64
                let allThreeTimes = puzzleList[0].elapsedTime + puzzleList[1].elapsedTime + puzzleList[2].elapsedTime
                
                let timeInterval = Double(allThreeTimes) / 1_000_000_000
                let seconds = Int(round(timeInterval))
                makeFancyTime(seconds: seconds, end: true)

                if currentUser?.value(forKey: "gameMode") as! String == "Noob" {
                    if curNoobTries > allThreeTries || curNoobTries == 0 {
                        currentUser?.setValue(allThreeTries, forKey: "noobTries")
                    }
                    if curNoobTime > allThreeTimes || curNoobTime == 0 {
                        currentUser?.setValue(allThreeTimes, forKey: "noobTime")
                        currentUser?.setValue(endTime, forKey: "noobFancyTime")
                    }
                } else if currentUser?.value(forKey: "gameMode") as! String == "Gamer" {
                    if curGamerTries > allThreeTries || curGamerTries == 0 {
                        currentUser?.setValue(allThreeTries, forKey: "gamerTries")
                    }
                    if curGamerTime > allThreeTimes || curGamerTime == 0 {
                        currentUser?.setValue(allThreeTimes, forKey: "gamerTime")
                        currentUser?.setValue(endTime, forKey: "gamerFancyTime")
                    }
                } else {
                    if curProTries > allThreeTries || curProTries == 0 {
                        currentUser?.setValue(allThreeTries, forKey: "proTries")
                    }
                    if curProTime > allThreeTimes || curProTime == 0 {
                        currentUser?.setValue(allThreeTimes, forKey: "proTime")
                        currentUser?.setValue(endTime, forKey: "proFancyTime")
                    }
                }

                saveContext()
                
            } else {
                puzzleList[puzzleIndex! + 1].changeStatus(value: 1)
                if puzzleCoreData {
                    // minitodo: put this in puzzle class function
                    corePuzzles[puzzleIndex!].setValue("Unlocked", forKey: "status")
                }
                msg = "You've unlocked the next puzzle :)"
            }
            saveContext()
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
            if guessField.text!.lowercased().count == 0 {
                wordTries.text = "Don't forget to guess!"
            } else if guessField.text!.lowercased().count != currentWord!.name.count {
                wordTries.text = "Invalid - check number of letters"
            } else if guessField.text!.lowercased() != currentWord!.name {
                incrementTries(correct: false)
                let guessedWord = Array(guessField.text!.lowercased())
                let clueLetters = Array(currentWord!.name)
                for guessedLetterInd in 0...(guessedWord.count-1) {
                    
                    if clueLetters.contains(guessedWord[guessedLetterInd]) {
                        if clueLetters[guessedLetterInd] == guessedWord[guessedLetterInd] {
                            currentWord!.wordLetters[guessedLetterInd].known = true
                            currentWord!.wordLetters[guessedLetterInd].crossingLetter?.known = true
                            if currentUser?.value(forKey: "gameMode") as! String == "Noob" {
                                currentWord!.wordLetters[guessedLetterInd].cwBox!.text = String(currentWord!.wordLetters[guessedLetterInd].letter)
                            }
                        } else {
                            if !currentWord!.yellowLetters.contains(guessedWord[guessedLetterInd]) {
                                currentWord!.yellowLetters.append(guessedWord[guessedLetterInd])
                                if currentUser?.value(forKey: "gameMode") as! String != "Pro" {
                                    currentYellows.text! += String(guessedWord[guessedLetterInd]) + " "
                                }
                            }
                        }
                    } else if !currentWord!.redLetters.contains(guessedWord[guessedLetterInd]) && !currentWord!.yellowLetters.contains(guessedWord[guessedLetterInd]) {
                        currentWord!.redLetters.append(guessedWord[guessedLetterInd])
                        if currentUser?.value(forKey: "gameMode") as! String != "Pro" {
                            currentReds.text! += String(guessedWord[guessedLetterInd]) + " "
                        }
                    }
                    
                    updateBlanks(word:currentWord!.name)
                }
            } else if guessField.text!.lowercased() == currentWord?.name {
                wordGuessed()
            }
        } else {
            wordTries.text = "Choose a clue first"
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

