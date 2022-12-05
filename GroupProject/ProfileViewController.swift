//
//  ProfileViewController.swift
//  GroupProject
//
//  Created by AAAVPrakash12 on 12/2/22.
//

import UIKit



class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let picker = UIImagePickerController()
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileName: UILabel!
    var allTries = [currentUser?.value(forKey: "noobTries"), currentUser?.value(forKey: "gamerTries"), currentUser?.value(forKey: "proTries")]
    var allTimers = [currentUser?.value(forKey: "noobTime"), currentUser?.value(forKey: "gamerTime"), currentUser?.value(forKey: "proTime")]
    
    let textCellIdentifier = "TableCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        profileName.text = currentUser!.value(forKey: "accountEmail") as? String
        
        view.backgroundColor = bgColor
        tableView.backgroundColor = bgColor

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.isUserInteractionEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        allTries = [currentUser?.value(forKey: "noobTries"), currentUser?.value(forKey: "gamerTries"), currentUser?.value(forKey: "proTries")]
        allTimers = [currentUser?.value(forKey: "noobFancyTime"), currentUser?.value(forKey: "gamerFancyTime"), currentUser?.value(forKey: "proFancyTime")]
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath) as! ScoreTableViewCell
        
        cell.gamemodeField.text = "\(gameModes[indexPath.row])"
        cell.triesField.text = "\(allTries[indexPath.row] ?? "tries problem")"
        cell.durationField.text = "\(allTimers[indexPath.row] ?? "timer problem")"
        
        
        cell.backgroundColor = bgColor
        cell.textLabel?.font = UIFont(name: "Noteworthy", size: 18)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameModes.count
    }
    
    @IBAction func changePicture(_ sender: Any) {
        
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagePick = info[.originalImage] as! UIImage
        profilePic.image = imagePick
        dismiss(animated: true)
    }

}
