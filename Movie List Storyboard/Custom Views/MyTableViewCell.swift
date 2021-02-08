//
//  MyTableViewCell.swift
//  Movie List Storyboard
//
//  Created by SaJesh Shrestha on 2/5/21.
//

import UIKit


class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var imdbID: UILabel!
    
    var myColDelegate: MyCollectionTableViewCell?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

