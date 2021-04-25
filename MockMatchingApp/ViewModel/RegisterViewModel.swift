//
//  RegisterViewModel.swift
//  MockMatchingApp
//
//  Created by Yotaro Ito on 2021/04/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol RegisterViewModelInputs {
    var nameTextInput:AnyObserver<String>{get}
    var emailTextInput:AnyObserver<String>{get}
    var passwordTextInput:AnyObserver<String>{get}

}

protocol RegisterViewModelOutputs {
    var nameTextOutPut: PublishSubject<String>{get}
    var emailTextOutPut: PublishSubject<String>{get}
    var passwordTextOutPut: PublishSubject<String>{get}

}

class RegisterViewModel: RegisterViewModelInputs, RegisterViewModelOutputs{
    
    private let disposeBag = DisposeBag()
    
    //   名前、パスワード、メールの値の確認し、正常な場合に認証ができる
    //    observable
    //    viewModelから出ていく情報
    var nameTextOutPut = PublishSubject<String>()
    var emailTextOutPut = PublishSubject<String>()
    var passwordTextOutPut = PublishSubject<String>()
    var validRegisterSubject = BehaviorSubject<Bool>(value: false)
    
     
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
    
    var validRegisterDriver: Driver<Bool> = Driver.never()
    
    init() {
        
        validRegisterDriver = validRegisterSubject
            .asDriver(onErrorDriveWith: Driver.empty())
        
//      RegisterViewController の setUpBindingsの中の  nameTextField.rx.textで渡した情報がここに呼ばれる
        let nameValid = nameTextOutPut
            .asObservable()
            .map { text -> Bool in
//                textが５文字以内の場合
                return text.count >= 5
            }
        
        let emailValid = emailTextOutPut
            .asObservable()
            .map { text -> Bool in
//                textが５文字以内の場合
                return text.count >= 5
            }
        
        let passwordValid = passwordTextOutPut
            .asObservable()
            .map { text -> Bool in
//                textが５文字以内の場合
                return text.count >= 5
            }
        
//        三つ全部がtrueだった場合の処理
        Observable.combineLatest(nameValid, emailValid, passwordValid) {$0 && $1 && $2 }
            .subscribe { validAll in
                self.validRegisterSubject.onNext(validAll)
            }
            .disposed(by: disposeBag)

        
    }
    
    
}
