//
//  TableViewController.swift
//  GroupProject
//
//  Created by AAAVPrakash12 on 11/10/22.
//

import UIKit
import CoreData

public class LetterClass {
    var letter:Character
    var known:Bool
    var index:Int
    var crossingLetter:LetterClass? = nil
    var cwBox:UILabel? = nil
    
    init(letter:Character, index:Int) {
        self.letter = letter
        self.known = false
        self.index = index
    }
    
    func assignCrossing(letter:LetterClass) {
        self.crossingLetter = letter
    }
    
    func assignBox(box:UILabel) {
        self.cwBox = box
    }
}

public class WordClass {
    var name:String
    var clueNum:Int
    var tag:String
    var tries:Int
    var wordLetters:Array<LetterClass>
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
            self.wordLetters.append(LetterClass(letter: wordComponents[letterInd], index:letterInd))
        }
    }
    
}

public class PuzzleClass {
    var title:String
    var status:String
    var image:UIImage
    var totalTries:Int
    var elapsedTime:UInt64
    var fancyTime:String
    var cluesCompleted:[String] = []
    
    var acrossList:[WordClass] = []
    var downList:[WordClass] = []
    
    init(title:String, status:String = "Locked", image:String) {
        self.title = title
        self.status = status
        self.image = UIImage(named: image)!
        self.totalTries = 0
        self.elapsedTime = 0
        self.fancyTime = "00:00:00"
    }
    
    func addAcross(word:WordClass) {
        word.tag = String(word.clueNum) + " Across"
        acrossList.append(word)
    }
    
    func addDown(word:WordClass) {
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
        var acrossWord:WordClass?
        var downWord:WordClass?
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

public var puzzleList:[PuzzleClass] = []
public var corePuzzles:[NSManagedObject] = []
public var puzzleIndex:Int? = nil

// bc coredata currently hates me
let puzzleCoreData = false
// editable variables for future updates
let image = "crossword1"
let numPuzzles = 3

class TableViewController: UITableViewController {
    
    let textCellIdentifier = "TextCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = bgColor
        
        // do not uncomment/delete:
        // clearPuzzleData()
        
        if puzzleCoreData {
            corePuzzles = retrievePuzzles()
            if corePuzzles.count == 0 {
                for _ in 1...numPuzzles {
                    let newPuzzle = NSEntityDescription.insertNewObject(forEntityName: "Puzzle", into: context)
                    newPuzzle.setValue(0, forKey: "totalTries")
                    newPuzzle.setValue(0, forKey: "elapsedTime")
                    newPuzzle.setValue("00:00:00", forKey: "fancyTime")
                    newPuzzle.setValue("Locked", forKey: "status")
                    newPuzzle.setValue([String](), forKey: "cluesCompleted")
                    newPuzzle.setValue([NSManagedObject](), forKey: "acrossWords")
                    newPuzzle.setValue([NSManagedObject](), forKey: "downWords")
                    corePuzzles.append(newPuzzle)
                }
                corePuzzles[0].setValue("Unlocked", forKey: "status")
                corePuzzles[0].setValue("UT Austin", forKey: "name")
                corePuzzles[1].setValue("Winter", forKey: "name")
                corePuzzles[2].setValue("Animals", forKey: "name")
                saveContext()
            }
        }
        
        if puzzleList.isEmpty {
            resetPuzzles()
        }
        
        tableView.reloadData()

    }
    
    func resetPuzzles() {
        puzzleList = []
        
        createPuzzle(name: "UT Austin", status: "Unlocked", image: image, acrossWords: ["bevo","longhorns","speedway"],  downWords: ["jester","hornsup","exams"])
        
        createPuzzle(name: "Winter", image: image, acrossWords: ["snow","avalanche","presents"], downWords: ["arctic","sweater","santa"])

        createPuzzle(name: "Animals", image: image, acrossWords: ["fish","steerling","chipmunk"], downWords: ["agouti","cheetah","panda"])
        
        tableView.reloadData()
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        let controller = UIAlertController(
            title: "Reset Puzzles?",
            message: "You will lose your progress",
            preferredStyle: .alert)
        controller.addAction(UIAlertAction(
            title: "yes",
            style: .default,
            handler: {_ in self.resetPuzzles()}))
        controller.addAction(UIAlertAction(
            title: "no",
            style: .cancel))
        present(controller, animated:true)
    }
    
    func clearWordData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Word")
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
    
    func clearPuzzleData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Puzzle")
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
            clearWordData()

        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
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
    
    func retrievePuzzles() -> [NSManagedObject] {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Puzzle")
        var fetchedResults:[NSManagedObject]? = nil

        do {
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            print(nserror)
            print(nserror.userInfo)
            abort()
        }
        return(fetchedResults)!
    }
    
    func createPuzzle(name:String, status:String = "Locked", image:String, acrossWords:Array<String>, downWords:Array<String>) {
        var acrossNums = [Int]()
        var downNums = [Int]()
        if image == "crossword1" {
            acrossNums = [3,4,5]
            downNums = [1,2,6]
        }
        
        let newPuzzle = PuzzleClass(title: name, status: status, image: image)
        puzzleList.append(newPuzzle)
        
        var currentCoreAcross = [NSManagedObject]()
        var currentCoreDown = [NSManagedObject]()
        for wordInd in 0...(acrossWords.count-1) {
            let newWord = WordClass(name: acrossWords[wordInd], clueNum: acrossNums[wordInd])
            newPuzzle.addAcross(word: newWord)
            
            if puzzleCoreData {
                currentCoreAcross = corePuzzles[puzzleList.count-1].value(forKey: "acrossWords") as! [NSManagedObject]
                if currentCoreAcross.count != acrossWords.count {
                    let coreWord = NSEntityDescription.insertNewObject(forEntityName: "Word", into: context)
                    coreWord.setValue(acrossWords[wordInd], forKey: "word")
                    coreWord.setValue(0, forKey: "tries")
                    coreWord.setValue([NSManagedObject](), forKey: "redLetters")
                    coreWord.setValue([NSManagedObject](), forKey: "yellowLetters")
                    currentCoreAcross.append(coreWord)
                    corePuzzles[puzzleList.count-1].setValue(currentCoreAcross, forKey: "acrossWords")
                }
                saveContext()
            }
        }
        for wordInd in 0...(downWords.count-1) {
            let newWord = WordClass(name: downWords[wordInd], clueNum: downNums[wordInd])
            newPuzzle.addDown(word: newWord)
            
            if puzzleCoreData {
                currentCoreDown = corePuzzles[puzzleList.count-1].value(forKey: "downWords") as! [NSManagedObject]
                if currentCoreDown.count != downWords.count {
                    let coreWord = NSEntityDescription.insertNewObject(forEntityName: "Word", into: context)
                    coreWord.setValue(downWords[wordInd], forKey: "word")
                    coreWord.setValue(0, forKey: "tries")
                    coreWord.setValue([NSManagedObject](), forKey: "redLetters")
                    coreWord.setValue([NSManagedObject](), forKey: "yellowLetters")
                    currentCoreDown.append(coreWord)
                    corePuzzles[puzzleList.count-1].setValue(currentCoreDown, forKey: "downWords")
                }
                saveContext()
            }
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
        var nameRN = ""
        var statusRN = ""
        var timeRN = ""
        var triesRN = 0
        if puzzleCoreData {
            nameRN = corePuzzles[row].value(forKey: "name") as! String
            if puzzleList[row].title != nameRN {
                print("row error")
            }
            statusRN = corePuzzles[row].value(forKey: "status") as! String
            timeRN = corePuzzles[row].value(forKey: "fancyTime") as! String
            triesRN = corePuzzles[row].value(forKey: "totalTries") as! Int
        } else {
            nameRN = puzzleList[row].title
            statusRN = puzzleList[row].status
            timeRN = puzzleList[row].fancyTime
            triesRN = puzzleList[row].totalTries
        }
        
        cell.textLabel?.text = "\(nameRN)\n   \(statusRN)"
        if currentUser?.value(forKey: "showTime") as! Bool {
            cell.textLabel?.text! += "\n   Elapsed Time: \(timeRN)"
        }
        if currentUser?.value(forKey: "showTries") as! Bool {
            cell.textLabel?.text! += "\n   Total Tries: \(triesRN)"
        }
        
        cell.backgroundColor = bgColor
        cell.textLabel?.numberOfLines = 4
        cell.textLabel?.font = UIFont(name: "Noteworthy", size: 18)
        
            return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        puzzleIndex = indexPath.row
        var statusRN = ""
        if puzzleCoreData {
            statusRN = corePuzzles[puzzleIndex!].value(forKey: "status") as! String
        } else {
            statusRN = puzzleList[puzzleIndex!].status
        }
        if statusRN != "Locked" {
            self.performSegue(withIdentifier: "TableToPuzzle", sender: self)
        } else {
            let controller = UIAlertController(
                title: "Puzzle Locked!",
                message: "This puzzle is currently locked.",
                preferredStyle: .alert)
            controller.addAction(UIAlertAction(
                title: "aw man",
                style: .default))
            present(controller, animated:true)
        }
    }
}
