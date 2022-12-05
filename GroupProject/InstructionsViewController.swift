//
//  InstructionsViewController.swift
//  GroupProject
//
//  Created by AAAVPrakash12 on 11/21/22.
//

import UIKit

class InstructionsViewController: UIViewController {

    @IBOutlet weak var weltBackground: UILabel!
    @IBOutlet weak var makeBackground: UILabel!
    @IBOutlet weak var sendBackground: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = bgColor
        
        weltBackground.layer.cornerRadius = 10
        makeBackground.layer.cornerRadius = 10
        sendBackground.layer.cornerRadius = 10
        weltBackground.layer.masksToBounds = true
        makeBackground.layer.masksToBounds = true
        sendBackground.layer.masksToBounds = true
    }

}
