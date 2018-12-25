//
//  TableViewCell.swift
//  BookStore
//
//  Created by Queralt Sosa Mompel on 25/12/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var bookImage: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var author: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var genre: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
