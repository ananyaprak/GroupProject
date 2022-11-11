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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        puzzleImage.image = puzzleList[puzzleIndex].image
        totalTries.text = "Total Tries: \(puzzleList[puzzleIndex].totalTries)"
        wordTries.text = ""
        wordSelected.text = ""
        wordBlanks.text = ""
        
        let acrossList = [across5, across4, across3, across2, across1]
        let nonAcross = (numButtons - 1) - puzzleList[puzzleIndex].across
        for i in 0...4 {
            if i <= nonAcross {
                acrossList[i]?.isHidden = true
            } else {
                acrossList[i]?.setTitle(String(puzzleList[puzzleIndex].acrossList[((numButtons - 1) - i)].clueNum), for: .normal)
            }
        }
        let downList = [down5, down4, down3, down2, down1]
        let nonDown = (numButtons - 1) - puzzleList[puzzleIndex].down
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
    }
    
    
    

    // ananya test!
    // zach test

}

