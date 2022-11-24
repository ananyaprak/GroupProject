//
//  TableViewController.swift
//  GroupProject
//
//  Created by AAAVPrakash12 on 11/10/22.
//

import UIKit

public class Letter {
    var letter:Character
    var known:Bool
    var index:Int
    var crossingLetter:Letter? = nil
    
    init(letter:Character, index:Int) {
        self.letter = letter
        self.known = false
        self.index = index
    }
    
    func assignCrossing(letter:Letter) {
        self.crossingLetter = letter
    }
}

public class Word {
    var name:String
    var clueNum:Int
    var tag:String
    var tries:Int
    var wordLetters:Array<Letter>
    var yellowLetters:Array<Character>
    var redLetters:Array<Character>
    
    init(name:String, clueNum:Int) {
        self.name = name
        self.clueNum = clueNum
        self.tag = "tba"
        self.tries = 0
        self.wordLetters = []
        self.yellowLetters = []
        self.redLetters = []
        let wordComponents = Array(name)
        for letterInd in 0...(wordComponents.count-1) {
            self.wordLetters.append(Letter(letter: wordComponents[letterInd], index:letterInd))
        }
    }
    
}

public class Puzzle {
    var title:String
    var status:String
    var image:UIImage
    var totalTries:Int
    var elapsedTime:UInt64
    var fancyTime:String
    var cluesCompleted:[String] = []
    
    var acrossList:[Word] = []
    var downList:[Word] = []
    
    init(title:String, status:String = "Locked", image:String) {
        self.title = title
        self.status = status
        self.image = UIImage(named: image)!
        self.totalTries = 0
        self.elapsedTime = 0
        self.fancyTime = "00:00:00"
    }
    
    func addAcross(word:Word) {
        word.tag = String(word.clueNum) + " Across"
        acrossList.append(word)
    }
    
    func addDown(word:Word) {
        word.tag = String(word.clueNum) + " Down"
        downList.append(word)
    }
    
    func changeStatus(value:Int) {
        if value == 0 {
            self.status = "Locked"
        } else if value == 1 {
            self.status = "Unlocked"
        } else if value == 2 {
            self.status = "Completed"
        }
    }
    
    func clueComplete(clue:String) {
        cluesCompleted.append(clue)
    }
    
    func assignCrossing(word1:String, letter1:Int, word2:String, letter2:Int) {
        var acrossWord:Word?
        var downWord:Word?
        for word in acrossList {
            if word.name == word1 {
                acrossWord = word
            }
        }
        for word in downList {
            if word.name == word2 {
                downWord = word
            }
        }
        let acrossLetter = acrossWord?.wordLetters[letter1]
        let downLetter = downWord?.wordLetters[letter2]
        acrossLetter?.assignCrossing(letter: downLetter!)
        downLetter?.assignCrossing(letter: acrossLetter!)
    }

}

public var puzzleList:[Puzzle] = []
public var puzzleIndex:Int? = nil

class TableViewController: UITableViewController {
    
    let textCellIdentifier = "TextCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if puzzleList.isEmpty {
            let image = "crossword1"
            
            createPuzzle(name: "UT Austin", status: "Unlocked", image: image, acrossWords: ["bevo","longhorns","speedway"],  downWords: ["jester","hornsup","exams"])
            
            createPuzzle(name: "Winter", image: image, acrossWords: ["snow","avalanche","presents"], downWords: ["arctic","sweater","santa"])

            createPuzzle(name: "Animals", image: image, acrossWords: ["fish","steerling","chipmunk"], downWords: ["agouti","cheetah","panda"])
        }
        
        tableView.reloadData()

    }
    
    func createPuzzle(name:String, status:String = "Locked", image:String, acrossWords:Array<String>, downWords:Array<String>) {
        var acrossNums = [Int]()
        var downNums = [Int]()
        if image == "crossword1" {
            acrossNums = [3,4,5]
            downNums = [1,2,6]
        }
        
        let newPuzzle = Puzzle(title: name, status: status, image: image)
        puzzleList.append(newPuzzle)
        
        for wordInd in 0...(acrossWords.count-1) {
            let newWord = Word(name: acrossWords[wordInd], clueNum: acrossNums[wordInd])
            newPuzzle.addAcross(word: newWord)
        }
        for wordInd in 0...(downWords.count-1) {
            let newWord = Word(name: downWords[wordInd], clueNum: downNums[wordInd])
            newPuzzle.addDown(word: newWord)
        }
        
        newPuzzle.assignCrossing(word1: acrossWords[0], letter1: 3, word2: downWords[1], letter2: 1)
        newPuzzle.assignCrossing(word1: acrossWords[1], letter1: 2, word2: downWords[1], letter2: 3)
        newPuzzle.assignCrossing(word1: acrossWords[1], letter1: 6, word2: downWords[0], letter2: 5)
        newPuzzle.assignCrossing(word1: acrossWords[2], letter1: 1, word2: downWords[1], letter2: 6)
        newPuzzle.assignCrossing(word1: acrossWords[2], letter1: 3, word2: downWords[2], letter2: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        puzzleIndex = nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return puzzleList.count
        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
            let row = indexPath.row
        cell.textLabel?.text = "\(puzzleList[row].title)\n   \(puzzleList[row].status)"
        if showTime {
            cell.textLabel?.text! += "\n   Elapsed Time: \(puzzleList[row].fancyTime)"
        }
        if showTries {
            cell.textLabel?.text! += "\n   Total Tries: \(puzzleList[row].totalTries)"
        }
            cell.textLabel?.numberOfLines = 4
            return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        puzzleIndex = indexPath.row
        if puzzleList[puzzleIndex!].status != "Locked" {
            self.performSegue(withIdentifier: "TableToPuzzle", sender: self)
        } else {
            let controller = UIAlertController(
                title: "Puzzle Locked!",
                message: "This puzzle is current locked.",
                preferredStyle: .alert)
            controller.addAction(UIAlertAction(
                title: "aw man",
                style: .default))
            present(controller, animated:true)
        }
    }
}
