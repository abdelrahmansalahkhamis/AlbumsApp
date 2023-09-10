//
//  ProfileHeader.swift
//  AlbumsApp
//
//  Created by Abdelrahman Salah on 10/09/2023.
//

import UIKit

class ProfileHeader: UITableViewHeaderFooterView {

    func setUpUI(userModel: UserModel){
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10 // Adjust spacing as needed

        let profileLbl = UILabel()
        profileLbl.text = "Profile"
        profileLbl.textAlignment = .left
        profileLbl.font = UIFont.systemFont(ofSize: 28, weight: .bold)


        let username = UILabel()
//        username.text = "Leanne Graham"
        username.text = userModel.name
        username.textAlignment = .left
        username.font = UIFont.systemFont(ofSize: 18, weight: .semibold)


        let userAddress = UILabel()
        userAddress.text = userModel.address.street + ", " + userModel.address.city + ", " + userModel.address.zipcode + ", " + userModel.address.suite
        userAddress.textAlignment = .left
        userAddress.font = UIFont.systemFont(ofSize: 18, weight: .medium)


        let myProfileLbl = UILabel()
        myProfileLbl.text = "My Profile"
        myProfileLbl.textAlignment = .center
        myProfileLbl.font = UIFont.systemFont(ofSize: 18, weight: .semibold)

        stackView.addArrangedSubview(profileLbl)
        stackView.addArrangedSubview(username)
        stackView.addArrangedSubview(userAddress)
        stackView.addArrangedSubview(myProfileLbl)

        self.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        // Center the stack view horizontally and vertically
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

}

