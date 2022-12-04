//
//  ProfileViewController.swift
//  GroupProject
//
//  Created by AAAVPrakash12 on 12/2/22.
//

import UIKit



class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileName: UILabel!
    var allTries = [currentUser?.value(forKey: "noobTries"), currentUser?.value(forKey: "gamerTries"), currentUser?.value(forKey: "proTries")]
    var allTimers = [currentUser?.value(forKey: "noobTime"), currentUser?.value(forKey: "gamerTime"), currentUser?.value(forKey: "proTime")]
    
    let textCellIdentifier = "TableCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(currentUser)
        
        profileName.text = currentUser!.value(forKey: "accountEmail") as! String
        
        view.backgroundColor = bgColor
        tableView.backgroundColor = bgColor

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.isUserInteractionEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        allTries = [currentUser?.value(forKey: "noobTries"), currentUser?.value(forKey: "gamerTries"), currentUser?.value(forKey: "proTries")]
        allTimers = [currentUser?.value(forKey: "noobTime"), currentUser?.value(forKey: "gamerTime"), currentUser?.value(forKey: "proTime")]
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath) as! ScoreTableViewCell
        
        cell.gamemodeField.text = "\(gameModes[indexPath.row])"
        cell.triesField.text = "\(allTries[indexPath.row]!)"
        cell.durationField.text = "\(allTimers[indexPath.row]!)"
        
        
        cell.backgroundColor = bgColor
        cell.textLabel?.font = UIFont(name: "Noteworthy", size: 18)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameModes.count
    }

}
