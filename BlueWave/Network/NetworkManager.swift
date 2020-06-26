//
//  NetworkManager.swift
//  BlueWave
//
//  Created by FreeBird on 5/5/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import FirebaseFirestore


//static func FirebaseErrAnalysis(err:Error?)->String{
//
//    var firebaseErrorMsgTxt: String = "Failed!"
//
//    if let errCode = AuthErrorCode(rawValue: err!._code) {
//
//         switch errCode {
//         case .emailAlreadyInUse:
//              firebaseErrorMsgTxt = "This email was used by others"
//         case .invalidEmail:
//              firebaseErrorMsgTxt = "Invalid email"
//         case.wrongPassword:
//              firebaseErrorMsgTxt = "Wrong Password!"
//         case.weakPassword:
//              firebaseErrorMsgTxt = "Password needs to be more than six charactors!"
//         case.tooManyRequests:
//              firebaseErrorMsgTxt = "Too many try. Please try again later"
//             default:
//              print("Create User Error: \(String(describing: err))")
//         }
//
//    }
//
//return firebaseErrorMsgTxt
//
//}

enum FirebaseError: Error {
    case emailAlreadyInUse
    case badRequest
    case unknownError
    case decodingError
    case invalidRefreshToken
    case invalidToken
}


class NetWorkManager: NSObject {
    
    static let shared = NetWorkManager()
    func getMarketPlaceLinks(completion: @escaping (Result<[MOLModel], Error>) -> ()){
        
        let collectionName = "market_outlooks"
        if Reachability.isConnectedToNetwork() {
            let db = Firestore.firestore()
            db.collection(collectionName)
            .getDocuments() { (querySnapshot, err) in
                if err != nil {
                    completion(.failure(err!))
                } else {
                
                    var videoLinks:[MOLModel] = []
                    for document in querySnapshot!.documents {
                        do {
                            
                            guard let videoLink: MOLModel = try document.data(as: MOLModel.self) else {return}
                            videoLinks.append(videoLink)
                        } catch {
                            print(error.localizedDescription)
                
                        }
                        
                    }
                    videoLinks.sort{$0.created.dateValue() > $1.created.dateValue()}
                    completion(.success(videoLinks))
                }
            }
        }
        else
        {
     
            completion(.failure("No Internet" as! Error))
        }
        
    }
    
    
    func getIAPmainInfoFromServer(completion: @escaping (Result<PerchaseInfo, Error>) -> ()){
        
        // let collectionName = "users"
        let docName = Auth.auth().currentUser?.uid ?? ""
        if Reachability.isConnectedToNetwork() {
           
           let ref = Firestore.firestore().collection("users").document(docName)
            ref.getDocument { (document, error) in
              if let error = error {
                  print(error.localizedDescription)

                  completion(.failure(error))
                  return
               }
               
                print(document?.data() as Any)
                
                do{
                    guard let signal: UserInfo = try document?.data(as: UserInfo.self) else {return}
               
                    let mainInfo = PerchaseInfo(model:signal)
                    print("okay")
                    completion(.success(mainInfo))
                }catch{
                    
                    completion(.failure(error))
                    print("failed")
                }
                
                
             
            }
        }else{
            completion(.failure("No Internet" as! Error))
        }
        
    }

}
