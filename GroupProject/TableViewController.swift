//
//  TableViewController.swift
//  GroupProject
//
//  Created by AAAVPrakash12 on 11/10/22.
//

import UIKit

public class Word {
    var name:String
    var clueNum:Int
    var tag:String
    var tries:Int
    var knownLetters:Array<Bool>
    
    init(name:String, clueNum:Int) {
        self.name = name
        self.clueNum = clueNum
        self.tag = "tba"
        self.tries = 0
        self.knownLetters = []
        let wordComponents = Array(name)
        for _ in wordComponents {
            self.knownLetters.append(false)
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
    
    var acrossList:[Word] = []
    var downList:[Word] = []
    
    init(title:String, status:String = "Locked", image:String) {
        self.title = title
        self.status = status
        self.image = UIImage(named: image)!
        self.totalTries = 0
        self.elapsedTime = 0
        self.fancyTime = "0:0:0"
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
}

public var puzzleList:[Puzzle] = []
public var puzzleIndex:Int? = nil

class TableViewController: UITableViewController {
    
    let textCellIdentifier = "TextCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if puzzleList.isEmpty {
            let newPuzzle = Puzzle(title: "UT Austin", image: "crossword1")
            puzzleList.append(newPuzzle)
            newPuzzle.changeStatus(value: 1)
            // TODO: add more puzzles
            var newWord = Word(name: "bevo", clueNum: 3)
            newPuzzle.addAcross(word: newWord)
            newWord = Word(name: "longhorns", clueNum: 4)
            newPuzzle.addAcross(word: newWord)
            newWord = Word(name: "speedway", clueNum: 6)
            newPuzzle.addAcross(word: newWord)
            newWord = Word(name: "tower", clueNum: 1)
            newPuzzle.addDown(word: newWord)
            newWord = Word(name: "hornsup", clueNum: 2)
            newPuzzle.addDown(word: newWord)
            newWord = Word(name: "jester", clueNum: 5)
            newPuzzle.addDown(word: newWord)
        }
        
        tableView.reloadData()

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
            print("alert")
        }
    }
}
