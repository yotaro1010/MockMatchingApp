//
//  ProfileImageView.swift
//  MockMatchingApp
//
//  Created by Yotaro Ito on 2021/04/28.
//

import UIKit

class ProfileImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        self.image = UIImage(named: "no_image")
        self.contentMode = .scaleToFill
        self.layer.cornerRadius = 90
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
