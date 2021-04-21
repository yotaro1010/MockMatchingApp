//
//  File.swift
//  MockMatchingApp
//
//  Created by Yotaro Ito on 2021/04/21.
//

import UIKit

class CardInfoLabel: UILabel {
    
//    goodとbadのlabel
    init(frame: CGRect, labelText: String, labelColor: UIColor) {
        super.init(frame: frame)
        
        
        font = .boldSystemFont(ofSize: 45)
        textColor = labelColor
        text = labelText
        layer.borderWidth = 3
        layer.borderColor = labelColor.cgColor
        layer.cornerRadius = 10
        
        textAlignment = .center
        alpha = 0
        
    }
    
//
    init(frame: CGRect, labelText: String, labelFont: UIFont) {
        super.init(frame: frame)

        font = labelFont
        textColor = .white
        text = labelText 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
