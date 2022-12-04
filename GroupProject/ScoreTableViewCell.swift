//
//  ScoreTableViewCell.swift
//  GroupProject
//
//  Created by AAAVPrakash12 on 12/2/22.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gamemodeField: UILabel!
    @IBOutlet weak var triesField: UILabel!
    @IBOutlet weak var durationField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
