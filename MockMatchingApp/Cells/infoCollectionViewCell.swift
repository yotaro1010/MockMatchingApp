//
//  infoCollectionViewCell.swift
//  MockMatchingApp
//
//  Created by Yotaro Ito on 2021/04/29.
//

import UIKit

class infoCollectionViewCell: UICollectionViewCell{
    
    var userForInfoCV:UserModel? {
//        userに情報が渡された時にdidSetが呼ばれる
        didSet {
            nameTextField.text = userForInfoCV?.name
            emailTextField.text = userForInfoCV?.email
        }
    }
    
    let nameLabel = ProfileLabel(title: "name")
    let ageLabel = ProfileLabel(title: "age")
    let emailLabel = ProfileLabel(title: "e-mail")
    let regidenceLabel = ProfileLabel(title: "regidence")
    let hobbyLabel = ProfileLabel(title: "hobby")
    let introductionLabel = ProfileLabel(title: "introduction")
    
    let nameTextField = ProfileTextField(placeHolder: "name")
    let ageTextField = ProfileTextField(placeHolder: "age")
    let emailTextField = ProfileTextField(placeHolder: "e-mail")
    let regidenceTextField = ProfileTextField(placeHolder: "regidence")
    let hobbyTextField = ProfileTextField(placeHolder: "hobby")
    let introductionTextField = ProfileTextField(placeHolder: "introduction")
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        let views = [
            [nameLabel, nameTextField],
            [ageLabel, ageTextField],
            [emailLabel, emailTextField],
            [regidenceLabel, regidenceLabel],
            [hobbyLabel, hobbyTextField],
            [introductionLabel, introductionTextField]]
        let stackViews = views.map { (views) -> UIStackView in
//            一番最初の要素をlabelとして取り出す
            guard let label = views.first as? UILabel,
//            二番めの要素をtextFieldとして取り出す 　無理だった場合は空のUIStackViewを取り出す
                  let textField = views.last as? UITextField else {return UIStackView()}
//            取り出した要素を stacViewに追加
            let stackView = UIStackView(arrangedSubviews: [label, textField])
            stackView.axis = .vertical
            stackView.spacing = 5
            textField.anchor(height: 50)
            return stackView
        }
        
        let baseStackView = UIStackView(arrangedSubviews:stackViews)
        baseStackView.axis = .vertical
        baseStackView.spacing = 15
        addSubview(baseStackView)
        
        nameTextField.anchor(width: UIScreen.main.bounds.width - 40, height: 80)
        baseStackView.anchor(top: topAnchor,bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 10, leftPadding: 20, rightPadding: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

