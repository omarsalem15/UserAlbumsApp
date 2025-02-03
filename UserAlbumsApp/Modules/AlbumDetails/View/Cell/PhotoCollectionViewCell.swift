//
//  PhotoCollectionViewCell.swift
//  UserAlbumsApp
//
//  Created by Omar Salem on 02/02/2025.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoTitle: UILabel!
    
    static let identifier = "PhotoCell"
    static func nib() -> UINib {
        return UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with photo: Photo) {
//        if let url = photo.url {
//            photoImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName:"magnifyingglass"))
//        } else {
//            photoImageView.image = UIImage(systemName: "magnifyingglass")
//        }
        
        let purpleImage = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/Solid_indigo.svg/600px-Solid_indigo.svg.png")
        photoTitle.text = photo.title
        photoImageView.sd_setImage(with: purpleImage, placeholderImage: UIImage(systemName: "magnifyingglass"))
    }

}
