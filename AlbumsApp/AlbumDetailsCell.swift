//
//  CustomCollectionViewCell.swift
//  AlbumsApp
//
//  Created by Abdelrahman Salah on 10/09/2023.
//

import UIKit

class AlbumDetailsCell: UICollectionViewCell {

    static let reuseIdentifier = "AlbumDetailsCell"

    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        label.frame = contentView.bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = UIColor.random()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
