//
//  NetworkManager.swift
//  AlbumsApp
//
//  Created by Abdelrahman Salah on 10/09/2023.
//

import Foundation
import Combine
import Moya
protocol NetworkManager{
    func fetchUsers() -> AnyPublisher<[UserModel], Error>
    func fetchAlbums(for userId: Int) -> AnyPublisher<[AlbumsModel], Error>
    func fetchPhotos(for albumId: Int) -> AnyPublisher<[PhotosModel], Error>
}

class NetworkManagerImp: NetworkManager {

    let provider = MoyaProvider<NetworkService>()

    func fetchUsers() -> AnyPublisher<[UserModel], Error> {
        return provider
            .requestPublisher(.getUsers)
            .map(\.data)
            .decode(type: [UserModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchAlbums(for userId: Int) -> AnyPublisher<[AlbumsModel], Error> {
        return provider
            .requestPublisher(.getAlbums(userId: userId))
            .map(\.data)
            .decode(type: [AlbumsModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchPhotos(for albumId: Int) -> AnyPublisher<[PhotosModel], Error> {
        return provider
            .requestPublisher(.getPhotos(albumId: albumId))
            .map(\.data)
            .decode(type: [PhotosModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
