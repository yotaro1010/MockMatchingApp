//
//  UserModel.swift
//  MockMatchingApp
//
//  Created by Yotaro Ito on 2021/04/26.
//

import Foundation
import FirebaseFirestore

class UserModel {
    var email: String
    var name: String
    var createdAt: Timestamp
    
    init(dictionary: [String: Any]){
//        dic型のkeyを指定
        self.email = dictionary["e-mail"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.createdAt = dictionary["createdAt"] as? Timestamp ?? Timestamp()
    }
}
