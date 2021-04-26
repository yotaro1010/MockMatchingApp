//
//  Firebase.swift
//  MockMatchingApp
//
//  Created by Yotaro Ito on 2021/04/25.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

extension Auth {
    static func createUsertoFireAuth(name: String?, email: String?, password: String?, completion: @escaping (Bool) -> Void){
        guard let email = email else {return}
        guard let password = password else {return}

        
        Auth.auth().createUser(withEmail: email, password: password) { (auth, error) in
            if let error = error {
                print("Failed to Authentification:", error)
                return
            }
             
            guard let uid = auth?.user.uid  else {return}
            Firestore.setUserDataToFireStore(name: name, email: email, uid: uid) { success in
                completion(success)
            }
        }
    }
    
    static func loginWithFireAuth(email: String, password: String, completion: @escaping (Bool) -> Void){
                
        Auth.auth().signIn(withEmail: email, password: password) { (response, error) in
            if let error = error {
                print("Failed to Login:", error)
                completion(false)
                return
            }
            print("Success: Login")
            completion(true)
        }
    }
    
}

extension Firestore {
    
// createUsertoFireAuthの処理が完了時、成功したことを知らせるためにsetUserDataToFireStoreの中にcompletionを作り、それを呼ぶ
    static  func setUserDataToFireStore(name: String?, email: String, uid: String, completion: @escaping (Bool) -> ()){
        
        guard let name = name else {return}
        
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
            completion(true)
            print("Success Authentification")
        }
    }
//    Firestoreからユーザー情報を取得
    static func fetchUserFromFirestore(uid: String, completion: @escaping (UserModel?) -> Void){
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, error) in
            if let error = error {
                print("faild to fetching user identification", error)
                completion(nil)
                return
            }
            guard let data = snapshot?.data() else {return}
            
            let user = UserModel(dictionary: data)
            completion(user)

        }
    }
}
