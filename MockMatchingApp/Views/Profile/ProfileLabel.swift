//
//  ProfileLabel.swift
//  MockMatchingApp
//
//  Created by Yotaro Ito on 2021/04/28.
//

import UIKit

class ProfileLabel: UILabel{
    init() {
        super.init(frame: .zero)
        self.font = .systemFont(ofSize: 45, weight: .bold)
        self.textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
