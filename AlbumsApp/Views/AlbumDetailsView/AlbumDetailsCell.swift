//
//  CustomCollectionViewCell.swift
//  AlbumsApp
//
//  Created by Abdelrahman Salah on 10/09/2023.
//

import UIKit

class AlbumDetailsCell: UICollectionViewCell {

    static let reuseIdentifier = "AlbumDetailsCell"

    let albumImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(albumImage)
        albumImage.frame = contentView.bounds
        albumImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    func setImage(with url: String) {
        albumImage.kf.setImage(with: URL(string: url))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
