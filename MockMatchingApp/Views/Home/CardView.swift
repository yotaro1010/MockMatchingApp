//
//  CardView.swift
//  MockMatchingApp
//
//  Created by Yotaro Ito on 2021/04/21.
//

import UIKit

class CardView:UIView{
    
//    背景色とlabelが被らないようにimageViewにグラデーションをつける
    private let gradientLayer = CAGradientLayer()
    private func setupGradientLayer(){
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.red.cgColor]
        gradientLayer.locations = [0.3, 1.1]
        cardImageView.layer.addSublayer(gradientLayer)
    }
    
//
    private let cardImageView = CardImageView(frame: .zero)
    private let infoButton = UIButton(type: .system).createCardInfoButton()
    
    private let nameLabel = CardInfoLabel(text: "Taro, 23", font: .systemFont(ofSize: 40,weight: .heavy))
    private let residenceLabel = CardInfoLabel(text: "日本, 東京", font: .systemFont(ofSize: 20, weight: .regular))
    private let hobbyLabel = CardInfoLabel(text: "サッカー", font: .systemFont(ofSize: 25, weight: .regular))
    private let introductionLabel = CardInfoLabel(text: "とにかくサッカーが好きです", font: .systemFont(ofSize: 25, weight: .regular))
    
    private let goodLabel = CardInfoLabel(text: "GOOD", textColor: .rgb(red: 137, green: 223, blue: 86))
    private let badLabel = CardInfoLabel(text: "BAD", textColor: .rgb(red: 222, green: 110, blue: 110))
    
    init(user: UserModel) {
        super.init(frame: .zero)
        setUpLayout(user: user)
        setupGradientLayer()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView(gesture:)))
        self.addGestureRecognizer(panGesture)
    }
    
//    Viewが生成された後に呼ばれる
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
    
    @objc func panCardView(gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: self)
        guard let view = gesture.view else {return}
        
        
        if gesture.state == .changed {
            
            self.handlePanChange(translation: translation)
            
        }else if gesture.state == .ended {
            self.handlePanEnded(view: view, translation: translation)
        }
    }
    
    private func handlePanChange(translation: CGPoint){
        let degree:CGFloat = translation.x / 20
        
//        円周率のπ = pi これを用いて半円を描くアニメーションを作る
        let angle = degree * CGFloat.pi / 100

        let rotateTranslation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotateTranslation.translatedBy(x: translation.x, y: translation.y)
        
//        alpha値は最大が1それを100分割にして調整
        let ratio: CGFloat = 1 / 100
        let ratioValue = ratio * translation.x
//        右側に動かしているとき
        if translation.x > 0{
            self.goodLabel.alpha = ratioValue
        }
//        左側に動かしているとき
        else if translation.x < 0 {
            self.badLabel.alpha = -ratioValue
        }
        
    }
    
//    cardから手を離したときに戻る動き
    private func handlePanEnded(view: UIView, translation: CGPoint){
//        x軸を基本としてマイナス側に行った時（左スワイプした時）
        if translation.x <= -120 {
            view.removeCardViewAnimation(x: -600)
        }
//        x軸を基本としてプラス側に行った時（右スワイプした時）
        else if translation.x >= 120 {
            view.removeCardViewAnimation(x: 600)
        }
//        それ以外の動き（Viewから手を離して元に戻る時）
        else {
            UIView.animate(withDuration: 1, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {
                self.transform = .identity
                self.layoutIfNeeded()
 //            戻るときにlabelのアルファ値を0にする
                self.goodLabel.alpha = 0
                self.badLabel.alpha = 0
            }
        }
        
       
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setUpLayout(user: UserModel){
        let infoVerticalStackView = UIStackView(arrangedSubviews: [residenceLabel, hobbyLabel, introductionLabel])
        infoVerticalStackView.axis = .vertical
        
        let baseStackView = UIStackView(arrangedSubviews: [infoVerticalStackView,infoButton])
        baseStackView.axis = .horizontal
        
//        viewの配置
        addSubview(cardImageView)
        addSubview(nameLabel)
        
        addSubview(baseStackView)
        addSubview(goodLabel)
        addSubview(badLabel)
        
        cardImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 10, rightPadding: 10)
        infoButton.anchor(width: 40)
        baseStackView.anchor(bottom: cardImageView.bottomAnchor,
                             left: cardImageView.leftAnchor,
                             right: cardImageView.rightAnchor,
                             bottomPadding: 20,
                             leftPadding: 20,
                             rightPadding: 20)
        nameLabel.anchor(bottom: baseStackView.topAnchor, left: cardImageView.leftAnchor, bottomPadding: 10, leftPadding: 20)
        goodLabel.anchor(top: cardImageView.topAnchor, left: cardImageView.leftAnchor, width: 140, height: 55, topPadding: 25, leftPadding: 20 )
        badLabel.anchor(top: cardImageView.topAnchor, right: cardImageView.rightAnchor, width: 140, height: 55, topPadding: 25, rightPadding: 20)
        
//      ユーザー情報をViewに反映
        nameLabel.text = user.name
        introductionLabel.text = user.email
    }
    
}

