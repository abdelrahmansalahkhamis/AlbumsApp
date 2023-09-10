//
//  ProfileScreen.swift
//  AlbumsApp
//
//  Created by Abdelrahman Salah on 09/09/2023.
//

import UIKit

class ProfileScreen: UITableViewController {


    var viewModel = AlbumViewModel(newsAPIService: NetworkManagerImp())

    // set currentUserId to 1 as the default choice
    var currentUserId: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.sectionHeaderHeight = 180

        viewModel.displayUsers()

        viewModel.displayAlbums(for: currentUserId)

        observeUser()
        observeAlbums()
    }

    private func observeUser() {
        viewModel.$users
            .receive(on: DispatchQueue.main)
            .sink { [weak self] users in
                self?.tableView.reloadData()
            }
            .store(in: &viewModel.bag)
    }

    private func observeAlbums() {
        viewModel.$albums
            .receive(on: DispatchQueue.main)
            .sink { [weak self] albums in
                self?.tableView.reloadData()
            }
            .store(in: &viewModel.bag)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.albums.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileAlbumCell", for: indexPath) as? ProfileAlbumCell else {
            return UITableViewCell()
        }
        cell.populateData(viewModel.albums[indexPath.row].title)

        return cell
    }


    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ProfileHeader()
        if viewModel.users.count > 0{
            let n = Int.random(in: 0..<viewModel.users.count)
            headerView.setUpUI(userModel: viewModel.users[n])
        }
        return headerView
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(AlbumDetailsScreen(albumId: viewModel.albums[indexPath.row].id), animated: false)
    }
}
