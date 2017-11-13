//
//  BookViewController.swift
//  BookCollector
//
//  Created by Radoslav Hlinka on 13/11/2017.
//  Copyright © 2017 Radoslav Hlinka. All rights reserved.
//

import UIKit

class BookViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var deleteBookButton: UIButton!
    var book : Book? = nil
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        if book != nil {
            bookImageView.image = UIImage(data: book!.image as! Data)
            titleTextField.text = book!.title
            
            addUpdateButton.setTitle("Update", for: .normal)
        }else{
            deleteBookButton.isHidden = true
        }
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
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addBookButton(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if book != nil{
            book!.title = titleTextField.text
            book!.image = UIImagePNGRepresentation(bookImageView.image!)
        } else {
            let book = Book(context: context)
            book.title = titleTextField.text
            book.image = UIImagePNGRepresentation(bookImageView.image!)
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(book!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
}
