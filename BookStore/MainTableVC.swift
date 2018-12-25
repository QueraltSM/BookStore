//
//  TableViewController.swift
//  BookStore
//
//  Created by Queralt Sosa Mompel on 23/12/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//

import UIKit
import Firebase

class MainTableVC: UITableViewController {

    @IBOutlet var booksTableView: UITableView!
    var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        booksTableView.dataSource = self
        booksTableView.delegate = self
        loadBooks()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    func loadBooks() {
        print("entro")
        Database.database().reference().child("Books").queryOrderedByKey().observe(.childAdded, with: {
            snapshot in
            let value = snapshot.value as? NSDictionary
            let id = value!["id"] as? String
            let title = value!["title"] as? String
            let author = value!["author"] as? String
            let date = value!["date"] as? String
            let genre = value!["genre"] as? String
            self.books.insert(Book(id:id,title:title,author:author,date:date,genre:genre), at: 0)
            self.booksTableView.reloadData()
        })
    }
    
    /*override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! TableViewCell
        let test = books[indexPath.row]
        cell.title?.text = test.title
        cell.author?.text = test.author
        cell.date?.text = test.date
        cell.genre?.text = test.genre
        //cell.image?.image = test.image
        return cell
    }
}
