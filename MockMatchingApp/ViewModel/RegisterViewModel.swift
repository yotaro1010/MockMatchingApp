//
//  RegisterViewModel.swift
//  MockMatchingApp
//
//  Created by Yotaro Ito on 2021/04/24.
//

import Foundation
import RxSwift

class RegisterViewModel{
    
    private let disposeBag = DisposeBag()
    
    //   名前、パスワード、メールの値の確認
    
    //    observable
    //    viewModelから出ていく情報
    var nameTextOutPut = PublishSubject<String>()
    var emailTextOutPut = PublishSubject<String>()
    var passwordTextOutPut = PublishSubject<String>()
     
    //   observer
    //    viewModelが受け取る情報
    var nameTextInput:AnyObserver<String>{
        nameTextOutPut.asObserver()
    }
    
    var emailTextInput:AnyObserver<String>{
        emailTextOutPut.asObserver()
    }
    
    var passwordTextInput:AnyObserver<String>{
        passwordTextOutPut.asObserver()
    }
    
    init() {
//      RegisterViewController の setUpBindingsの中の  nameTextField.rx.textで渡した情報がここに呼ばれる
        nameTextOutPut.asObservable().subscribe { text in
            print("name:", text)
        }
        .disposed(by: disposeBag)
        
        emailTextOutPut.asObservable().subscribe { text in
            print("email:", text)
        }
        .disposed(by: disposeBag)
        
        passwordTextOutPut.asObservable().subscribe { text in
            print("password:", text)
        }
        .disposed(by: disposeBag)
    }
    
    
}
