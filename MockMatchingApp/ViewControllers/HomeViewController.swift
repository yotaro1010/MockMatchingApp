//
//  ViewController.swift
//  MockMatchingApp
//
//  Created by Yotaro Ito on 2021/04/19.
//

import UIKit
import RxSwift
import FirebaseAuth
import FirebaseFirestore

class HomeViewController: UIViewController {
    
    private var userModel: UserModel?
    
    private let disposeBag = DisposeBag()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
//    loginしていたらHomeVCを表示、logoutしていたらregisterVCを表示させる
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser?.uid == nil {
            let regiterVC = RegisterViewController()
 //            navVCによってregisterVCとloginVCを結合させる
            let navVC = UINavigationController(rootViewController: regiterVC)
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: true, completion: nil)
        }
    }
    
//    userのデータをuidによって識別、FirestoreからHomeVCに持ってくる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.fetchUserFromFirestore(uid: uid) { (user) in
 //        ここでデータを取得すると、ユーザーのデータはdictionary型で取得できる。
  //        これをuserModelを作って変換する。
            if let user = user {
                self.userModel = user
            }
        }

    }
    
    private func setupLayout(){
        let topControlView = TopControlView()
        
        let cardView = CardView()
       
        let bottomControlView = BottomControlView()
       
        
        let stackView = UIStackView(arrangedSubviews: [topControlView, cardView, bottomControlView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical

        
        self.view.addSubview(stackView)
        self.view.addSubview(logoutButton)
        
        [
            topControlView.heightAnchor.constraint(equalToConstant: 100),
            bottomControlView.heightAnchor.constraint(equalToConstant: 120),

            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor)
        
        ].forEach { $0.isActive = true }
        
        logoutButton.anchor(bottom: view.bottomAnchor, left: view.leftAnchor, bottomPadding: 10, leftPadding: 10)
        
        logoutButton.rx.tap
            .asDriver()
            .drive {[weak self] _ in
                self?.tappedLogout()
            }
            .disposed(by: disposeBag)
    }
    
    private func tappedLogout(){
        do {
            try Auth.auth().signOut()
            
            let regiterVC = RegisterViewController()
            let navVC = UINavigationController(rootViewController: regiterVC)
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: true, completion: nil)
            
        }catch {
//             do catch は自動的にerrorを含む
            print("Faild to Logout:", error)
        }
    }
}
