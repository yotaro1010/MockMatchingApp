//
//  RegisterViewController.swift
//  MockMatchingApp
//
//  Created by Yotaro Ito on 2021/04/22.
//

import UIKit
import RxSwift
//　authでできるのはユーザーの認証のみ、データを管理するのではない
import FirebaseAuth
// 認証されたデータを管理
import FirebaseFirestore

class RegisterViewController :UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = RegisterViewModel()

    private let registerTitleLabel = RegisterTitleLabel()
    private let nameTextField = RegisterTextField(placeHolder: "名前")
    private let emailTextField = RegisterTextField(placeHolder: "e-mail")
    private let passwordTextField = RegisterTextField(placeHolder: "password")
    private let registerButton = RegisterButton()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGradientLayer()
        setUpLayout()
        setUpBindings()
       
    }
    
    private func setUpLayout(){
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
//                ここでviewModelにデータを渡す
                self?.viewModel.nameTextInput.onNext(text ?? "")
            }
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.emailTextInput.onNext(text ?? "")

            }
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.passwordTextInput.onNext(text ?? "")

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
            self.setUserDataToFireStore(email: email, uid: uid)
        }
    }
    private func setUserDataToFireStore(email: String, uid: String){
        
        guard let name = nameTextField.text else {return}
        
//      dictionary型のユーザー情報を
        let document = [
            "name" : name,
            "e-mail" : email,
            "createdAt": Timestamp()
        ] as [String : Any]
        
//        認証情報に紐づいたIDによって保存
        Firestore.firestore().collection("users").document(uid).setData(document) { error in
            if let error = error {
                print("Failed to Authentification:", error)
                return
            }
            print("Success Authentification")
        }
    }
}
