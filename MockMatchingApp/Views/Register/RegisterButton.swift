//
//  RegisterButton.swift
//  MockMatchingApp
//
//  Created by Yotaro Ito on 2021/04/22.
//

import UIKit

class RegisterButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet{
            self.backgroundColor = isHighlighted ? .rgb(red: 227, green: 48, blue: 78, alpha: 0.2) : .rgb(red: 227, green: 48, blue: 78)
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        setTitle("登録", for: .normal)
        backgroundColor = .rgb(red: 227, green: 48, blue: 78)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 10
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
