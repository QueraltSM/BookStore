//
//  MainVCViewController.swift
//  BookStore
//
//  Created by Queralt Sosa Mompel on 23/12/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//

import UIKit
import Firebase


class MainVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var saveBook: UIButton!
    @IBOutlet var bookImage: UIImageView!
    @IBOutlet var bookTitle: UITextField!
    @IBOutlet var bookAuthor: UITextField!
    @IBOutlet var bookDate: UITextField!
    @IBOutlet var bookGenre: UITextField!
    let imagePicker = UIImagePickerController()
    @IBOutlet var pickPhoto: UIButton!
    var refBooks: DatabaseReference!
    var imageURL : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        refBooks = Database.database().reference().child("Books")
    }
    
    func alert(titleParam : String, messageParam: String) {
        let title = titleParam
        let message = messageParam
        let okText = "Ok"
        let alert = UIAlertController(title: title, message : message, preferredStyle: UIAlertControllerStyle.alert)
        let okayButton = UIAlertAction(title: okText, style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(okayButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveImage(key: String) {
        let storageRef = Storage.storage().reference().child("Books Images").child("\(key).png")
        guard let imageData = UIImageJPEGRepresentation(bookImage.image!, 0.75) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                storageRef.downloadURL { url, error in
                }
            } else {
                let title = "Failed to save photo"
                self.alert(titleParam: title, messageParam : (error?.localizedDescription)!)
            }
        }
    }
 
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera",message: "Sorry, this device has no camera",preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",style:.default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC,animated: true,completion: nil)
    }
    
    func shootPhoto () {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker,animated: true,completion: nil)
        } else {
            noCamera()
        }
    }
    
    func photoFromGallery() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        imagePicker.modalPresentationStyle = .popover
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func saveInfo(_ sender: Any) {
        addBook()
    }
    
    func addBook(){
        let key = refBooks.childByAutoId().key
        let book = ["id":key,
                      "title": bookTitle.text! as String,
                      "author": bookAuthor.text! as String,
                      "date": bookDate.text! as String,
                      "genre": bookGenre.text! as String
            ]
        refBooks.child(key).setValue(book)
        saveImage(key: key)
    }
    
    @IBAction func pickPhoto(_ sender: Any) {
        let alertController = UIAlertController.init(title:"Select a photo", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "Gallery", style: .default, handler: { (action) in
            self.photoFromGallery()
        }))
        alertController.addAction(UIAlertAction.init(title: "Camera", style: .default, handler: { (action) in
            self.shootPhoto()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info : [String:Any]) {
        if let im = info[UIImagePickerControllerOriginalImage] as? UIImage {
            bookImage.image = im
            bookImage.contentMode = .scaleAspectFit
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
