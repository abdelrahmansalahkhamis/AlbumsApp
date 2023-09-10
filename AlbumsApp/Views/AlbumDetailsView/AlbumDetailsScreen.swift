//
//  ViewController.swift
//  AlbumsApp
//
//  Created by Abdelrahman Salah on 10/09/2023.
//

import UIKit
import Kingfisher

class AlbumDetailsScreen: UIViewController, UICollectionViewDataSource {


    let searchController = UISearchController(searchResultsController: nil)

    var photosArr: [PhotosModel] = []

    var searchArr: [PhotosModel] = []
    var isSearching: Bool = false

    private var collectionView: UICollectionView?

    var albumId: Int
    var viewModel = AlbumViewModel(newsAPIService: NetworkManagerImp())
    init(albumId: Int) {
        self.albumId = albumId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSearchController()
        configureCollectionView()

        viewModel.displayPhotos(for: albumId)

        observePhotos()
    }

    private func observePhotos() {
        viewModel.$photos
            .receive(on: DispatchQueue.main)
            .sink { [weak self] photos in
                self?.photosArr = photos
                self?.collectionView?.reloadData()
            }
            .store(in: &viewModel.bag)
    }

    func configureCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        let size = (view.frame.size.width - 4) / 3
        layout.itemSize = CGSize(width: size, height: size)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .systemBackground
        collectionView?.register(AlbumDetailsCell.self, forCellWithReuseIdentifier: AlbumDetailsCell.reuseIdentifier)


        guard let collectionView = collectionView else {return}

        view.addSubview(collectionView)
        collectionView.frame = view.bounds

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func configureSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = .done
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search"
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? searchArr.count : photosArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumDetailsCell.reuseIdentifier, for: indexPath) as! AlbumDetailsCell

        if isSearching {
            cell.setImage(with: searchArr[indexPath.row].thumbnailURL)
        } else {
            cell.setImage(with: photosArr[indexPath.row].thumbnailURL)
        }
        return cell
    }
}

extension AlbumDetailsScreen: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty {
            isSearching = true
            searchArr.removeAll()
            for item in photosArr {
                if item.title.lowercased().contains(searchText.lowercased()) {
                    searchArr.append(item)
                }
            }
        } else {
            isSearching = false
            searchArr.removeAll()
            searchArr = photosArr
        }
        collectionView?.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchArr.removeAll()
        collectionView?.reloadData()
    }

}
