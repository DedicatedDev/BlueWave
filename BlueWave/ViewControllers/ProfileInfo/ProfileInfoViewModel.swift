//
//  ProfileInfoViewModel.swift
//  BlueWave
//
//  Created by FreeBird on 4/20/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth


struct UserInfo: Codable {
    var name: String = ""
    var imageLink:String = ""
    var phonenumber: String = ""
    var country: String = ""
    var city: String = ""
    var address : String = ""
    var memberShipInfoIOS:Receipt?
    
}

class ProfileInfoVM{
    
    var fullUserInfo = UserInfo()
    
    func getUserInfo (completion: @escaping (Bool, String) -> ()) {
        
        if Reachability.isConnectedToNetwork() {
            
            let db = Firestore.firestore()
            let docName:String = Auth.auth().currentUser?.uid ?? "user"
            let docRef = db.collection("users").document(docName)
             docRef.getDocument(source: .cache) { (document, error) in
                 do {
                     guard let user: UserInfo = try document?.data(as: UserInfo.self) else {return}
                      
                    self.fullUserInfo = user
                    completion(true,"ok")
                 } catch {
                     print(error)
                    
                    completion(false,"We will get back you soon!")
                 }
             }


        }
        else
        {
            completion (false, "NoInternet")
        }
        
    }
    
    
    func Authentication(userEmail : String, userPasscode : String, vc: UIViewController,completion: @escaping (Bool) -> ()){
          
          
          let progressbar = vc.setProgressbar()
          progressbar.startAnimating()
          Auth.auth().signIn(withEmail: userEmail, password:userPasscode) { (result, err) in
                     
             if err != nil{
                 
              let msg:String = Utility.FirebaseErrAnalysis(err: err)
                     progressbar.stopAnimating()
                     Utility.showMsg(vc: vc, title: "Blue Wave", msgTxt: msg)
                    
                     completion(false)

             }else{
                 
                     progressbar.stopAnimating()
                     completion(true)
             }
          
        }

      }

    
}
