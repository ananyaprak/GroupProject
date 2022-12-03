//
//  ProfileViewController.swift
//  GroupProject
//
//  Created by AAAVPrakash12 on 12/2/22.
//

import UIKit



class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let textCellIdentifier = "TableCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = bgColor
        tableView.backgroundColor = bgColor

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.isUserInteractionEnabled = false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = "\(gameModes[indexPath.row])"
    
        cell.backgroundColor = bgColor
        cell.textLabel?.font = UIFont(name: "Noteworthy", size: 18)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameModes.count
    }

}
