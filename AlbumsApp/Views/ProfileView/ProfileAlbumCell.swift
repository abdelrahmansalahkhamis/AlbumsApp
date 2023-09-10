//
//  ProfileAlbumCell.swift
//  AlbumsApp
//
//  Created by Abdelrahman Salah on 09/09/2023.
//

import UIKit

class ProfileAlbumCell: UITableViewCell {

    @IBOutlet weak var albumLbl: UILabel!

    func populateData(_ albumName: String){
        self.albumLbl.text = albumName
    }

}
