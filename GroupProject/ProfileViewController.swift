//
//  ProfileViewController.swift
//  GroupProject
//
//  Created by AAAVPrakash12 on 12/2/22.
//

import UIKit
import AVFoundation

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
        
        let controller = UIAlertController(
            title: "Change Picture",
            message: "",
            preferredStyle: .alert)
        controller.addAction(UIAlertAction(
            title: "Choose from Library",
            style: .default,
            handler: {_ in self.library()}))
        controller.addAction(UIAlertAction(
            title: "Take Picture",
            style: .default,
            handler: {_ in self.camera()}))
        controller.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel))
        present(controller, animated:true)
    }
    
    func library() {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func camera() {
        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) {
                    accessGranted in
                    guard accessGranted == true else { return }
                }
            case .authorized:
                break
            default:
                print("Access denied")
                return
            }
            
            picker.allowsEditing = false
            picker.sourceType = .camera
            picker.cameraCaptureMode = .photo
            present(picker, animated: true)
        } else {
            
            let alertVC = UIAlertController(title: "No camera", message: "This device doesn't have a rear camera", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertVC.addAction(okAction)
            present(alertVC, animated: true)
        }
        
        if UIImagePickerController.availableCaptureModes(for: .front) != nil {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) {
                    accessGranted in
                    guard accessGranted == true else { return }
                }
            case .authorized:
                break
            default:
                print("Access denied")
                return
            }
            
            picker.allowsEditing = false
            picker.sourceType = .camera
            picker.cameraCaptureMode = .photo
            present(picker, animated: true)
        } else {
            
            let alertVC = UIAlertController(title: "No camera", message: "This device doesn't have a front camera", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertVC.addAction(okAction)
            present(alertVC, animated: true)
        }
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
