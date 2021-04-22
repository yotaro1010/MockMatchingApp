//
//  RegisterViewController.swift
//  MockMatchingApp
//
//  Created by Yotaro Ito on 2021/04/22.
//

import UIKit
import RxSwift
import FirebaseAuth

class RegisterViewController :UIViewController {
    
    private let disposeBag = DisposeBag()
    

    private let registerTitleLabel = RegisterTitleLabel()
    private let nameTextField = RegisterTextField(placeHolder: "名前")
    private let emailTextField = RegisterTextField(placeHolder: "e-mail")
    private let passwordTextField = RegisterTextField(placeHolder: "password")
    private let registerButton = RegisterButton()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGradientLayer()
        setUpBindings()
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpLayout()
    }
    
    private func setUpLayout(){
        passwordTextField.isSecureTextEntry = true
        let baseStackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, registerButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        view.addSubview(baseStackView)
        view.addSubview(registerTitleLabel)
        
//      stackViewの中の一つのインスタンスの高さを決めると、それに準拠した均等な高さの値を割り振ってくれる
        nameTextField.anchor(height: 40)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 40, rightPadding: 40)
        registerTitleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor, bottomPadding: 20)
    }
    
    private func setUpGradientLayer(){
        let layer = CAGradientLayer()
        
        let startColor = UIColor.rgb(red: 227, green: 48, blue: 78).cgColor
        let endColor = UIColor.rgb(red: 245, green: 208, blue: 108).cgColor

        layer.colors = [startColor, endColor]
        layer.locations = [0.0, 1.3]
        
        layer.frame = view.bounds
        
        view.layer.addSublayer(layer)
    }
    
    private func setUpBindings(){
        nameTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                
            }
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                
            }
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                
            }
            .disposed(by: disposeBag)
        
        registerButton.rx.tap
            .asDriver()
            .drive {[weak self] _ in
//                ボタンをタップしたときにユーザーの情報をfirebaseに保存
                self?.createUsertoFireAuth()
            }
            .disposed(by: disposeBag)

    }
    
    private func createUsertoFireAuth(){
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}

        
        Auth.auth().createUser(withEmail: email, password: password) { (auth, error) in
            if let error = error {
                print("Failed to Authentification:", error)
                return
            }
            
            guard let uid = auth?.user.uid  else {return}
            print("Success Authentification:", uid)
        }
    }
    
}
