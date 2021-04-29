//
//  ProfileTextField.swift
//  MockMatchingApp
//
//  Created by Yotaro Ito on 2021/04/29.
//

import UIKit

class ProfileTextField: UITextField {
    init(placeHolder: String) {
        super.init(frame: .zero)
        self.borderStyle = .roundedRect
        self.placeholder = placeholder
        self.backgroundColor = .rgb(red: 245, green: 245, blue: 245)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
