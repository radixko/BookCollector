//
//  BookViewController.swift
//  BookCollector
//
//  Created by Radoslav Hlinka on 13/11/2017.
//  Copyright © 2017 Radoslav Hlinka. All rights reserved.
//

import UIKit

class BookViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }

    @IBAction func photosButton(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        bookImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraButton(_ sender: Any) {
        imagePicker.sourceType = .camera
        
        
    }
    
    @IBAction func addBookButton(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let game = Book(context: context)
        game.title = titleTextField.text
        game.image = UIImagePNGRepresentation(bookImageView.image!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
}
