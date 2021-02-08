//
//  MyCollectionTableViewCell.swift
//  Movie List Storyboard
//
//  Created by SaJesh Shrestha on 2/8/21.
//

import UIKit


protocol MyCollectionTableViewCellDelegate {
    func selectedCollectionIndex(idx: Int)
}


class MyCollectionTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    
    var movies: [MovieProp] = []
    var images: [UIImage] = []
    var coreDataMovie: [MovieProps] = []
    var isNetwork = false
    
    var colDelegate: MyCollectionTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureCollectionView()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    fileprivate func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}


//MARK: - UICollectionView Extension
extension MyCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
        
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
        colDelegate?.selectedCollectionIndex(idx: indexPath.row)
    }
}


extension MyCollectionTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.contentView.bounds.width - 16) / 2.2
        return CGSize(width: width, height: width * 1.2)
    }
    
}
