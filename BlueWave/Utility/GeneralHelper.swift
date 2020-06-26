//
//  GeneralHelper.swift
//  BlueWave
//
//  Created by FreeBird on 4/12/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//
import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class MessageHelper{

        static func showMsg(vc : UIViewController, title:String, msgTxt:String) {
            
            let alert = UIAlertController(title: title, message: msgTxt, preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                
                
            }))
         

            vc.present(alert, animated: true)
        }
        
        static func showMsgForResult(vc : UIViewController, title:String, msgTxt:String) {
            
            let alert = UIAlertController(title: title, message: msgTxt, preferredStyle: .alert)

       //     alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            
            vc.present(alert, animated: true)
        }
        
}


class Utility{
    static func SmartStringForXML(s:String?)->String{
        
        var smartString:String = s!
        
        smartString = smartString.replacingOccurrences(of: "&lt;/p&gt", with: "", options: .literal, range: nil)
        smartString = smartString.replacingOccurrences(of: "&lt;p&gt;", with: "", options: .literal, range: nil)
        smartString = smartString.replacingOccurrences(of: "$", with: "")
        smartString = smartString.replacingOccurrences(of: "#", with: "")
        smartString = smartString.replacingOccurrences(of: "&", with: "and")
        smartString = smartString.replacingOccurrences(of: ";", with: "")
        smartString = smartString.replacingOccurrences(of: "*", with: "")
        return smartString
    }
    
    static func SmartDescription(s:String?)->String{
        
        
        var smartString:String = s!
        
        smartString = smartString.replacingOccurrences(of: "&lt;/p&gt", with: "\n", options: .literal, range: nil)
        smartString = smartString.replacingOccurrences(of: "&lt;p&gt;", with: "\n", options: .literal, range: nil)
        smartString = smartString.replacingOccurrences(of: "&#039;", with: "'", options: .literal, range: nil)
        smartString = smartString.replacingOccurrences(of: "&amp;", with: "&", options: .literal, range: nil)

        return smartString
        
    }
    
    
    //    static func CartEncoderToJson(data:[BookCartModel]){
    //
    //        var productInfo : [ProductInfoForCheckout] = []
    //        for product in data {
    //
    //            var checkoutProduct = ProductInfoForCheckout()
    //            checkoutProduct.id = product.productInfo?.ID
    //            checkoutProduct.qty = product.qty
    //            productInfo.append(checkoutProduct)
    //        }
    //
    //        let requestData : CartCoderbleModel = CartCoderbleModel(userkey: UserDefaults.standard.string(forKey: "userkey"), productInfo: productInfo)
    //        let jsonEncoder = JSONEncoder()
    //        let jsonData = try! jsonEncoder.encode(requestData)
    //        let json = String(data: jsonData, encoding: String.Encoding.utf8)
    //
    //        print(json ?? "No")
    //    }
    
    static func showMsg(vc : UIViewController, title:String, msgTxt:String) {
          
          let alert = UIAlertController(title: title, message: msgTxt, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
       

          vc.present(alert, animated: true)
      }
      
      static func showMsgForResult(vc : UIViewController, title:String, msgTxt:String) {
          
          let alert = UIAlertController(title: title, message: msgTxt, preferredStyle: .alert)

        //  alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
          alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
          
          vc.present(alert, animated: true)
      }
    
     static func FirebaseErrAnalysis(err:Error?)->String{
         
         var firebaseErrorMsgTxt: String = "Failed!"

         if let errCode = AuthErrorCode(rawValue: err!._code) {

              switch errCode {
              case .emailAlreadyInUse:
                   firebaseErrorMsgTxt = "This email was used by others"
              case .invalidEmail:
                   firebaseErrorMsgTxt = "Invalid email"
              case.wrongPassword:
                   firebaseErrorMsgTxt = "Wrong Password!"
              case.weakPassword:
                   firebaseErrorMsgTxt = "Password needs to be more than six charactors!"
              case.tooManyRequests:
                   firebaseErrorMsgTxt = "Too many try. Please try again later"
              case.userNotFound:
                   firebaseErrorMsgTxt = "Please input correct email address!"
                  default:
                   print("Create User Error: \(String(describing: err))")
              }
         
         }
     
     return firebaseErrorMsgTxt
     
    }
    
   static func jsonTwo(){
    
        let url = Bundle.main.url(forResource: "countries", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let JSON = try! JSONSerialization.jsonObject(with: data, options: [])
    
    // print(".........." , JSON , ".......")
    
    var locatinInfo: [String: [String]] = [:]
    
        if JSON is [String: [String]] {
            
            locatinInfo = JSON  as! [String: [String]]
        }
    

    GlobalVariables.LocationInfo = Utility.sortWithKeys(locatinInfo) as! [String: [String]] //countruryTuple.reduce(into: [:]) { $0[$1.0] = $1.1 }
    

    }
    
    
    static func sortWithKeys(_ dict: [String: Any]) -> [String: Any] {
        let sorted = dict.sorted(by: { $0.key < $1.key })
        var newDict: [String: Any] = [:]
        for sortedDict in sorted {
            newDict[sortedDict.key] = sortedDict.value
        }
        return newDict
    }
    
    static func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    
    static func isValidEmail(testStr:String) -> Bool {
              print("validate emilId: \(testStr)")
              let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
              let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
              let result = emailTest.evaluate(with: testStr)
              return result
    }
    
//    static func fetchLocationData() {
//           
//           do {
//               let countryData = try Data(contentsOf: Bundle.main.url(forResource: "countries", withExtension: "json")!)
//           
//               counties = try JSONDecoder().decode([Country].self, from: countryData)
//            
//        
//            print("Yes")
//              
//           } catch {
//            print("Yes")
//               print(error)
//            print("Yes")
//           }
//       }
    
    
    static func AskEmail(vc:UIViewController){
        
        let alert = UIAlertController(title: "Blue Wave", message: "Please input your Email", preferredStyle: .alert)
               
               alert.addTextField()
               alert.textFields![0].placeholder = "Your Email"
            
        
           
               alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                                 
                             print("No")
                         }))
               
               alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
                   
                   let email = alert.textFields![0].text
                   let progressbar = vc.setProgressbar()
                   progressbar.color = UIColor(hexString: "#222222")
                   
                   progressbar.startAnimating()
                   if email != nil {

                    Auth.auth().sendPasswordReset(withEmail: email!) { (err) in
                        progressbar.stopAnimating()
                        
                        if err != nil{
                             
                            let msg = Utility.FirebaseErrAnalysis(err: err)
                            Utility.showMsgForResult(vc: vc, title: "BlueWave", msgTxt: msg)
                            
                        }else{
                            
                            Utility.showMsgForResult(vc: vc, title: "BlueWave", msgTxt: "Please check your mailbox!")
                    
                        }
                    }
                }
                
               }))
                  
               
               vc.present(alert, animated: true)
        
    }

    static func AskPassword(vc: UIViewController){
        
        
       let alert = UIAlertController(title: "Blue Wave", message: "Please input your password", preferredStyle: .alert)
        
        alert.addTextField()
        alert.textFields![0].placeholder = "Your Password"
        alert.textFields![0].isSecureTextEntry = true
        alert.textFields![0].textContentType = .password
    
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                          
                      print("No")
                  }))
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            
            let inputedPasscode = alert.textFields![0].text
            let progressbar = vc.setProgressbar()
            progressbar.color = UIColor(hexString: "#222222")
            
            progressbar.startAnimating()
            if inputedPasscode != nil {

                self.Authentication(userEmail: Auth.auth().currentUser?.email ?? "1", userPasscode: inputedPasscode!, vc: vc){
                      (success) in
                        if(success) {
                                                        
                            progressbar.stopAnimating()
                                
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "checked"), object: nil)
                           
                           }else{
                            progressbar.stopAnimating()
                              self.showMsg(vc: vc, title: "Blue Wave", msgTxt: "Wrong Password!")
                           }
                      }
              
            } else {
                
                 self.showMsg(vc: vc, title: "Blue Wave", msgTxt: "Please input password!")
            }
        
        }))
           
        
        vc.present(alert, animated: true)
        
    }
    
    static func Authentication(userEmail : String, userPasscode : String, vc: UIViewController,completion: @escaping (Bool) -> ()){
          
          
          let progressbar = vc.setProgressbar()
          progressbar.startAnimating()
          Auth.auth().signIn(withEmail: userEmail, password:userPasscode) { (result, err) in
                     
             if err != nil{
                 
              
              let msg:String = self.FirebaseErrAnalysis(err: err)
                     progressbar.stopAnimating()
                     Utility.showMsg(vc: vc, title: "Blue Wave", msgTxt: msg)
                    
                     completion(false)

             }else{
                 
                     progressbar.stopAnimating()
                     completion(true)
             }
          
        }

      }
    
    static func resizeImage(image: UIImage, targetSize: CGSize,option:Int) -> UIImage {
           
           switch option {
           case 0:
               
               let size = image.size

               let widthRatio  = targetSize.width  / size.width
               let heightRatio = targetSize.height / size.height

               // Figure out what our orientation is, and use that to form the rectangle
               var newSize: CGSize
               if(widthRatio > heightRatio) {
                   newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
               } else {
                   newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
               }

               // This is the rect that we've calculated out and this is what is actually used below
               let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

               // Actually do the resizing to the rect using the ImageContext stuff
               UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
               image.draw(in: rect)
               let newImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
               UIGraphicsEndImageContext()

               return newImage
               
           case 1:
               
               let size = image.size

               let ratio:CGFloat = size.height/size.width
               let width = targetSize.width
               // Figure out what our orientation is, and use that to form the rectangle
               var newSize: CGSize
             
               newSize = CGSize(width: width, height: width * ratio)

               // This is the rect that we've calculated out and this is what is actually used below
               let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

               // Actually do the resizing to the rect using the ImageContext stuff
               UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
               image.draw(in: rect)
               let newImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
               UIGraphicsEndImageContext()

               return newImage
               
           case 2:
               
             let size = image.size

             let ratio:CGFloat = size.height/size.width
             let height = targetSize.height
             // Figure out what our orientation is, and use that to form the rectangle
             var newSize: CGSize
           
             newSize = CGSize(width: size.width/ratio, height: height)

             // This is the rect that we've calculated out and this is what is actually used below
             let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

             // Actually do the resizing to the rect using the ImageContext stuff
             UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
             image.draw(in: rect)
             let newImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
             UIGraphicsEndImageContext()

             return newImage
               
           default:
               
               return image
           }
            
        }

}




