//
//  ViewController.swift
//  MockMatchingApp
//
//  Created by Yotaro Ito on 2021/04/19.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let view1 = TopControlView()
        
        let view2 = UIView()
        view2.backgroundColor = .blue
        
        let bottomControlView = BottomControlView()
       
        
        let stackView = UIStackView(arrangedSubviews: [view1, view2, bottomControlView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical

        
        self.view.addSubview(stackView)
        
        [
            view1.heightAnchor.constraint(equalToConstant: 100),
            bottomControlView.heightAnchor.constraint(equalToConstant: 120),

            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor)
        
        ].forEach { $0.isActive = true }

    }


}

