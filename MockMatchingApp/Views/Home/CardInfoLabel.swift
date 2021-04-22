//
//  File.swift
//  MockMatchingApp
//
//  Created by Yotaro Ito on 2021/04/21.
//

import UIKit

class CardInfoLabel: UILabel {
    
//    goodとbadのlabel
    init(text: String, textColor: UIColor) {
        super.init(frame: .zero)
        
        
        font = .boldSystemFont(ofSize: 45)
        self.textColor = textColor
        self.text = text
        layer.borderWidth = 3
        layer.borderColor = textColor.cgColor
        layer.cornerRadius = 10
        
        textAlignment = .center
        alpha = 0
        
    }
    
//
    init(text: String, font: UIFont) {
        super.init(frame: .zero)

        self.font = font
        textColor = .white
        self.text = text 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
