//
//  LoginViewController.swift
//  MockMatchingApp
//
//  Created by Yotaro Ito on 2021/04/25.
//

import UIKit
import RxSwift
import FirebaseAuth
import PKHUD

class LoginViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let registerTitleLabel = RegisterTitleLabel(text: "Login")
    private let emailTextField = RegisterTextField(placeHolder: "e-mail")
    private let passwordTextField = RegisterTextField(placeHolder: "password")
    private let loginButton = RegisterButton(text: "Login")
    private let yetCreatedButton = UIButton(type: .system).createAboutAccountButton(text: "If you havent create own account yet")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGradientLayer()
        setUpLayout()
        setupBindings()
    }
    
    private func setUpLayout(){
        let baseStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        view.addSubview(baseStackView)
        view.addSubview(registerTitleLabel)
        view.addSubview(yetCreatedButton)
        

        emailTextField.anchor(height: 40)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 40, rightPadding: 40)
        registerTitleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor, bottomPadding: 20)
        yetCreatedButton.anchor(top: baseStackView.bottomAnchor, centerX: view.centerXAnchor, topPadding: 20)
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
    
    private func setupBindings(){
        yetCreatedButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.login()
            }
            .disposed(by: disposeBag)
    }
    
    private func login(){
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
//       ???????????????????????????????????????????????????
        HUD.show(.progress)
        Auth.loginWithFireAuth(email: email, password: password) {(success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }else {
            }
        }
//            login???????????????????????????Firebase????????????????????????????????????????????????,
//            ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????,
//            ????????????????????????????????????????????????
        
    }
}
