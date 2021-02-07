//
//  DetailCollectionVC.swift
//  Movie List Storyboard
//
//  Created by SaJesh Shrestha on 2/7/21.
//

import UIKit

class DetailCollectionVC: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var imdbIDLabel: UILabel!
    
    var year: String?
    var imdbID: String?
    var titleTxt: String?
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text         = titleTxt
        yearLabel.text          = year
        imdbIDLabel.text        = imdbID
        posterImageView.image   = image
    }
    
}
