//
//  MyCollectionViewCell.swift
//  Movie List Storyboard
//
//  Created by SaJesh Shrestha on 2/7/21.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func set(image: UIImage, label: String) {
        posterImageView.image = image
        titleLabel.text = label
    }
}
