//
//  ProfileViewController.swift
//  MockMatchingApp
//
//  Created by Yotaro Ito on 2021/04/28.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var userForProfileCV: UserModel?
    private let cellId = "cellId"
    let saveButton = UIButton(type: .system).createProfileTopButton(title: "save")
    let logoutButton =  UIButton(type: .system).createProfileTopButton(title: "Logout")
    let profileEditButton = UIButton(type: .system).createProfileEditButtton()
    let profileImageView = ProfileImageView()
    let nameLabel = ProfileLabel()
    
//    画像とlabelの下の細かい設定ができるViewは、StackViewを内側に配置したcollectionViewによって作る。
    lazy var infoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
//        中のcellのアイテム(View)のサイズをもとに自動的にサイズが変わる
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        cv.register(infoCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        return cv
    }()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    private func setupLayout(){
        view.backgroundColor = .white

        view.addSubview(saveButton)
        view.addSubview(logoutButton)
        view.addSubview(profileEditButton)
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(infoCollectionView)
        
        nameLabel.text = "Test"
        
        saveButton.anchor(top: view.topAnchor, left: view.leftAnchor, topPadding: 20, leftPadding: 15)
        logoutButton.anchor(top: view.topAnchor, right: view.rightAnchor, topPadding: 20, rightPadding: 15)
        profileImageView.anchor(top: view.topAnchor, centerX: view.centerXAnchor, width: 180, height: 180, topPadding: 60)
        nameLabel.anchor(top: profileImageView.bottomAnchor, centerX: view.centerXAnchor, topPadding: 20)
        profileEditButton.anchor(top: profileImageView.topAnchor, right: profileImageView.rightAnchor, width: 60, height: 60)
        infoCollectionView.anchor(top: nameLabel.bottomAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, topPadding: 20)
        
//      HomeVCから渡されたユーザー情報を反映
        nameLabel.text = userForProfileCV?.name
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = infoCollectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! infoCollectionViewCell
        cell.userForInfoCV = self.userForProfileCV
        return cell
    }
}


