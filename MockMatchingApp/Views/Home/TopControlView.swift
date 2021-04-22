//
//  TopControlView.swift
//  MockMatchingApp
//
//  Created by Yotaro Ito on 2021/04/19.
//
import RxCocoa
import UIKit
import RxSwift

class TopControlView: UIView {
    
    private let disposeBag = DisposeBag()
    
    let tinderButton = createTapButton(imageName: "tinder", unselectedImageName: "tinder_unselected")
    let goodButton = createTapButton(imageName: "good", unselectedImageName: "good_unselected")
    let commentButton = createTapButton(imageName: "comment", unselectedImageName: "comment_unselected")
    let profileButton = createTapButton(imageName: "profile", unselectedImageName: "profile_unselected")
    
    static private func createTapButton(imageName: String, unselectedImageName: String) -> UIButton{
        let button = UIButton(type: .custom)
        
//        buttonを選択したときのイメージ
        button.setImage(UIImage(named: unselectedImageName), for: .normal)
        button.setImage(UIImage(named: imageName), for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        button.setTitle("tap", for: .normal)
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setUpLayout()
        setUpBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout(){
        let baseStackView = UIStackView(arrangedSubviews: [tinderButton, goodButton, commentButton, profileButton])
        baseStackView.axis = .horizontal
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 43
        baseStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(baseStackView)
        
        baseStackView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 40, rightPadding: 40)
        
//        [
//            baseStackView.topAnchor.constraint(equalTo: topAnchor),
//            baseStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            baseStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
//            baseStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            
//        ].forEach{ $0.isActive = true }
        
        tinderButton.isSelected = true
    }
    
    private func setUpBindings(){
        
//        observerがobservableに指示を送りobservableが実行する
//        stream
        
//        rxCocoaのメソッド
//        tapによってobserverが起動、observableに指示、 クロージャの中の処理を実行
        tinderButton.rx.tap
//            driver　subscribeを加工したもの。(subscribeの上位互換？)メインスレッドで実行される、またはエラーを流さない特徴がある。エラーが起きないUIの処理を保証してくれる。
//            ex) ボタンタップなどによるエラーをおこさない
            
            .asDriver()
            .drive(onNext: {[weak self] _ in
                guard let self = self else {return}
                self.handleSelectedButton(selectedButton: self.tinderButton)

            })
        
            
//            tapしたときの処理
//            subscribeにstreamが流れ込んでいるイメージ
//            tapによって流れに変化が起きる
            

    
//            .subscribe { _ in
//                self.handleSelectedButton(selectedButton: self.tinderButton)
//            }
//            流れが行き着く地点。流れ（処理）が終わるとそれを破棄してくれる。これがないとずっと処理が続いてしまい、メモリのリークなどが起きることがある
            .disposed(by: disposeBag)
        
        goodButton.rx.tap
//            tapしたときの処理
            .asDriver()
            .drive(onNext: {[weak self] _ in
                guard let self = self else {return}
                self.handleSelectedButton(selectedButton: self.goodButton)
            })
            .disposed(by: disposeBag)
        
        commentButton.rx.tap
//            tapしたときの処理
            .asDriver()
            .drive(onNext: {[weak self] _ in
                guard let self = self else {return}
                self.handleSelectedButton(selectedButton: self.commentButton)
            })
            .disposed(by: disposeBag)
        
        profileButton.rx.tap
//            tapしたときの処理
            .asDriver()
            .drive(onNext: {[weak self] _ in
                guard let self = self else {return}
                self.handleSelectedButton(selectedButton: self.profileButton)
            })
            .disposed(by: disposeBag)
    }
    
    private func handleSelectedButton(selectedButton: UIButton){
//        ボタンの配列を作り、タップされたボタンのみ選択時状態として表示、それ以外は未選択の状態として表示にする
        let buttons = [tinderButton,goodButton,commentButton, profileButton]
        buttons.forEach{ button in
            if button == selectedButton {
                button.isSelected = true
            }else {
                button.isSelected = false
            }
        }
        
        
    }
   
}
