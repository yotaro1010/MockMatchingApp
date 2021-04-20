//
//  CardView.swift
//  MockMatchingApp
//
//  Created by Yotaro Ito on 2021/04/21.
//

import UIKit

class CardView:UIView{
    
    let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .heavy)
        label.textColor = .white
        label.text = "Taro, 23"
        return label
    }()
    
    let infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "info.circle.fill")?.resize(size: .init(width: 40, height: 40)), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let residenceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.text = "日本, 東京"
        return label
    }()
    
    let hobbyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textColor = .white
        label.text = "サッカー"
        return label
    }()
    
    let introductionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textColor = .white
        label.text = "とにかくサッカーが好き"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView(gesture:)))
        self.addGestureRecognizer(panGesture)
    }
    
    @objc func panCardView(gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: self)
        if gesture.state == .changed {
            self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        }else if gesture.state == .ended {
            UIView.animate(withDuration: 0.3) {
                self.transform = .identity
                self.layoutIfNeeded()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout(){
        let infoVerticalStackView = UIStackView(arrangedSubviews: [residenceLabel, hobbyLabel, introductionLabel])
        infoVerticalStackView.axis = .vertical
        
        let baseStackView = UIStackView(arrangedSubviews: [infoVerticalStackView,infoButton])
        baseStackView.axis = .horizontal
        
        
        addSubview(cardImageView)
        addSubview(nameLabel)
        addSubview(baseStackView)
        
        cardImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 10, rightPadding: 10)
        infoButton.anchor(width: 40)
        baseStackView.anchor(bottom: cardImageView.bottomAnchor,
                             left: cardImageView.leftAnchor,
                             right: cardImageView.rightAnchor,
                             bottomPadding: 20,
                             leftPadding: 20,
                             rightPadding: 20)
        nameLabel.anchor(bottom: baseStackView.topAnchor, left: cardImageView.leftAnchor, bottomPadding: 10, leftPadding: 20)

    }
    
}

