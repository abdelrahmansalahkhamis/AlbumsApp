//
//  AlbumsModel.swift
//  AlbumsApp
//
//  Created by Abdelrahman Salah on 10/09/2023.
//

import Foundation

struct AlbumsModel: Codable {
    let userID, id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}
