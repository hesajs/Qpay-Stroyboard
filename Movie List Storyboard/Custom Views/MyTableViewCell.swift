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
    @IBOutlet weak var collectionView: UICollectionView!

    var movies: [MovieProp] = []
    var images: [UIImage] = []
    var coreDataMovie: [MovieProps] = []
    var isNetwork = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        configureCollectionView()
    }
    
    fileprivate func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
    }

}

//MARK: - UICollectionView Extension
extension MyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isNetwork{ return images.count }
        else { return coreDataMovie.count }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewIdentifier", for: indexPath) as! MyCollectionViewCell
        
        if isNetwork {
            if !movies.isEmpty {
                cell.set(image: images[indexPath.row], label: movies[indexPath.row].movieTitle)
            }
        } else {
            if !coreDataMovie.isEmpty { cell.set(image: UIImage(data: coreDataMovie[indexPath.row].posterImage!)!, label: coreDataMovie[indexPath.row].title!)
            }
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = mainStoryBoard.instantiateViewController(identifier: "DetailCollectionVC") as! DetailCollectionVC
        if isNetwork {
            destinationVC.image     = images[indexPath.item]
            destinationVC.imdbID    = movies[indexPath.item].imdbID
            destinationVC.titleTxt  = movies[indexPath.item].movieTitle
            destinationVC.year      = movies[indexPath.item].year
        } else {
            destinationVC.titleTxt  = coreDataMovie[indexPath.item].title
            destinationVC.year      = coreDataMovie[indexPath.item].year
            destinationVC.imdbID    = coreDataMovie[indexPath.item].imdbID
            destinationVC.image     = UIImage(data: coreDataMovie[indexPath.item].posterImage!)
        }
        navigationController?.pushViewController(destinationVC, animated: true)
    }
        
}


extension MyTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.bounds.width - 16) / 2.2
        return CGSize(width: width, height: width)
    }
    
}
