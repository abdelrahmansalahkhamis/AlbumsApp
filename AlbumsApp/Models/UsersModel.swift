//
//  UsersModel.swift
//  AlbumsApp
//
//  Created by Abdelrahman Salah on 10/09/2023.
//

import Foundation

struct UserModel: Codable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}


// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}


// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String
}
