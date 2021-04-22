//
//  RegisterViewController.swift
//  MockMatchingApp
//
//  Created by Yotaro Ito on 2021/04/22.
//

import UIKit

class RegisterViewController :UIViewController {
    
    private let nameTextField = RegisterTextField(placeHolder: "名前")
    private let emailTextField = RegisterTextField(placeHolder: "e-mail")
    private let passwordTextField = RegisterTextField(placeHolder: "password")

    
//    let nameTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "名前"
//        textField.borderStyle = .roundedRect
//        textField.font = .systemFont(ofSize: 14)
//        return textField
//    }()
//
//    let emailTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "名前"
//        textField.borderStyle = .roundedRect
//        textField.font = .systemFont(ofSize: 14)
//        return textField
//    }()
//
//    let passwordTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "名前"
//        textField.borderStyle = .roundedRect
//        textField.font = .systemFont(ofSize: 14)
//        return textField
//    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("登録", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        let baseStackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, registerButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        view.addSubview(baseStackView)
        
        
//      stackViewの中の一つのインスタンスの高さを決めると、それに準拠した均等な高さの値を割り振ってくれる
        nameTextField.anchor(height: 40)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 40, rightPadding: 40)
    }
}
