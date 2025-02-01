//
//  AlbumTableViewCell.swift
//  UserAlbumsApp
//
//  Created by Omar Salem on 01/02/2025.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    @IBOutlet weak var albumNameLabel: UILabel!
    
    static let identifier = "AlbumCell"
    static func nib() -> UINib {
        return UINib(nibName: "AlbumTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        separatorInset = .zero
    }

   
}
