//
//  ViewController.swift
//  BookCollector
//
//  Created by Radoslav Hlinka on 13/11/2017.
//  Copyright © 2017 Radoslav Hlinka. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var books : [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let book = books[indexPath.row]
        cell.textLabel?.text = book.title
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            try books = context.fetch(Book.fetchRequest())
            print(books)
        }catch{
        }
    }
}

