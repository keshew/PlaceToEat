//
//  NewPlaceViewController.swift
//  PlaceToEat
//
//  Created by Артём Коротков on 28.07.2022.
//

import UIKit
import SwiftUI

class NewPlaceViewController: UITableViewController, UINavigationControllerDelegate {

    var imageIsChanged = false
    var currentPlace : Place?
    
    @IBOutlet var ratingControl: RationgControl!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var placeImage: UIImageView!
    @IBOutlet var placeName: UITextField!
    @IBOutlet var placeLocation: UITextField!
    @IBOutlet var placeType: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: tableView.frame.size.width,
                                                         height: 1))
        
        saveButton.isEnabled = false
        placeName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        setupEditScreen()
                
    }
    
    //MARK: TableView delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if indexPath.row == 0 {
            
            let cameraIcon = #imageLiteral(resourceName: "cameraIcon")
            let photoIcon = #imageLiteral(resourceName: "photoIcon")
            
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
        } else {
            view.endEditing(true)
        }
    }
    
    
    
    private func setupEditScreen() {
        if currentPlace != nil {
            
            setupNavigationBar()
            imageIsChanged = true
            
            guard let data = currentPlace?.imageData, let image = UIImage(data: data) else { return }
            
            placeImage.image = image
            placeImage.contentMode = .scaleAspectFill
            placeName.text = currentPlace?.name
            placeLocation.text = currentPlace?.location
            placeType.text = currentPlace?.type
            ratingControl.rating = Int(currentPlace!.rating)
        }
    }
    
    private func setupNavigationBar() {
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = currentPlace?.name
        saveButton.isEnabled = true
        
        
    }
    
    
    
    
    
    
    
    @IBAction func cancelAction(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    

    
}
    //MARK: - TextField delegate
    
    extension NewPlaceViewController: UITextFieldDelegate {
        
        //hide keyboard by tap on "DONE"
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        @objc private func textFieldChanged() {
            
            if placeName.text?.isEmpty == false {
                saveButton.isEnabled = true
            } else {
                saveButton.isEnabled = false
            }
        }
        
        func savePlace() {
            
            var image: UIImage?
            
            if imageIsChanged {
                image = placeImage.image
            } else {
                image = #imageLiteral(resourceName: "imagePlaceholder")
            }
            
            let imageData = image?.pngData()
            let newPlace = Place(name: placeName.text!,
                                 location: placeLocation.text,
                                 type: placeType.text,
                                 imageData: imageData,
                                 rating: Double(ratingControl.rating))
            
            if currentPlace != nil {
                try! realm.write {
                    currentPlace?.name = newPlace.name
                    currentPlace?.location = newPlace.location
                    currentPlace?.type = newPlace.type
                    currentPlace?.imageData = newPlace.imageData
                    currentPlace?.rating = newPlace.rating
                }
            } else {
                storageManager.saveObjc(newPlace)
            }
        }
        
    }
    
    //MARK: - Work with Image

    extension NewPlaceViewController: UIImagePickerControllerDelegate {
    
        func chooseImagePicker(source: UIImagePickerController.SourceType) {
            
            if UIImagePickerController.isSourceTypeAvailable(source) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = source
                present(imagePicker, animated: true)
            }
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            placeImage.image = info[.editedImage] as? UIImage
            placeImage.contentMode = .scaleAspectFill
            placeImage.clipsToBounds = true
            imageIsChanged = true
            
            dismiss(animated: true)
        }
        
}

