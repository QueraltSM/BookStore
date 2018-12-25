//
//  Book.swift
//  BookStore
//
//  Created by Queralt Sosa Mompel on 25/12/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//


class Book {
    var id: String?
    var title: String?
    var author: String?
    var date: String?
    var genre: String?
    
    init(id: String?, title: String?, author: String?, date: String?, genre: String?){
        self.id = id
        self.title = title
        self.author = author
        self.date = date
        self.genre = genre
    }
}
