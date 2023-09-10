//
//  ProfileScreen.swift
//  AlbumsApp
//
//  Created by Abdelrahman Salah on 09/09/2023.
//

import UIKit

class ProfileScreen: UITableViewController {

    let albumsArr: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.sectionHeaderHeight = 180
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albumsArr.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileAlbumCell", for: indexPath) as? ProfileAlbumCell else {
            return UITableViewCell()
        }
        cell.papulateData(albumsArr[indexPath.row])

        return cell
    }


    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ProfileHeader()
        headerView.setUpUI()
        return headerView
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(AlbumDetailsScreen(), animated: false)
    }
}
