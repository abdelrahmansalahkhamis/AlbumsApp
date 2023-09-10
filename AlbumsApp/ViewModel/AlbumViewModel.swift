//
//  AlbumViewModel.swift
//  AlbumsApp
//
//  Created by Abdelrahman Salah on 10/09/2023.
//

import Combine

class AlbumViewModel: ObservableObject{
    private let newsAPIService: NetworkManager

    @Published var users: [UserModel] = []
    @Published var albums: [AlbumsModel] = []
    @Published var photos: [PhotosModel] = []
    @Published var isRefreshing: Bool = false

    var bag = Set<AnyCancellable>()
    init(newsAPIService: NetworkManager = NetworkManagerImp()) {
        self.newsAPIService = newsAPIService
    }

    func displayUsers() {
        isRefreshing = true
        newsAPIService.fetchUsers()
            .sink { [weak self] _ in
                do{ self?.isRefreshing = false }
            } receiveValue: { [weak self] users in
                self?.users = users
            }
            .store(in: &bag)
    }

    func displayAlbums(for userId: Int){
        isRefreshing = true
        newsAPIService.fetchAlbums(for: userId)
            .sink { [weak self] _ in
                do{ self?.isRefreshing = false }
            } receiveValue: { [weak self] albums in
                self?.albums = albums.map({$0})
            }
            .store(in: &bag)
    }

    func displayPhotos(for albumId: Int){
        isRefreshing = true
        newsAPIService.fetchPhotos(for: albumId)
            .sink { [weak self] _ in
                do{ self?.isRefreshing = false }
            } receiveValue: { [weak self] photos in
                self?.photos = photos.map({$0})
            }
            .store(in: &bag)
    }
}

