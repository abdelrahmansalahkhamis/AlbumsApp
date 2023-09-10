//
//  ViewController.swift
//  AlbumsApp
//
//  Created by Abdelrahman Salah on 10/09/2023.
//

import UIKit

class AlbumDetailsScreen: UIViewController, UICollectionViewDataSource {

    let colors: [UIColor] = [.red, .green, .blue, .yellow, .purple, .orange]

    let searchController = UISearchController(searchResultsController: nil)

    var arr: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]

    var searchArr: [String] = ["11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
    private let reuseIdentifier = "AlbumDetailsCell"
    var isSearching: Bool = false

    private var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSearchController()
        configureCollectionView()
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
        return isSearching ? searchArr.count : arr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumDetailsCell.reuseIdentifier, for: indexPath) as! AlbumDetailsCell
        cell.label.text = "\(indexPath.item)"

        if isSearching {
            cell.label.text = searchArr[indexPath.row]
            //cell.papulateData(searchArr[indexPath.row])
            //label.text = searchArr[indexPath.row]
        } else {
            cell.label.text = arr[indexPath.row]
            //label.text = arr[indexPath.row]

            //cell.papulateData(arr[indexPath.row])

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
            for item in arr {
                if item.lowercased().contains(searchText.lowercased()) {
                    searchArr.append(item)
                }
            }
        } else {
            isSearching = false
            searchArr.removeAll()
            searchArr = arr
        }
        collectionView?.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchArr.removeAll()
        collectionView?.reloadData()
    }

}


extension UIColor {
    static func random() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
