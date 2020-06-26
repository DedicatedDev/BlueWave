//
//  LoginVCViewController.swift
//  BlueWave
//
//  Created by FreeBird on 4/11/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class RootVC: UIViewController {

    var container = UIStackView()
    var buttonContainer = SemiRadiusView()
    var logoImagView = UIImageView(image: #imageLiteral(resourceName: "finallogo"))
    let imageWrapperView = UIView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        Utility.jsonTwo()
       
        tabBarController?.tabBar.isHidden = true       
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
         safeAreaHeight = view.safeAreaInsets.bottom
        if Auth.auth().currentUser?.uid != nil{
            RegisterDevice()
            let productIds = Set<String>(arrayLiteral: RegisteredPurchase.oneMonth.rawValue,RegisteredPurchase.threeMonth.rawValue,RegisteredPurchase.sixMonth.rawValue)

                IAPManager.shared.verifySubscriptions(with: productIds) { (result, ids, success) in
                    
                    if success{
                        self.getMemberShipInfo()
                       // GlobalVariables.currentUserInfo.purchaseStatus = true
                        let keyWindow = UIApplication.shared.connectedScenes
                           .filter({$0.activationState == .foregroundActive})
                           .map({$0 as? UIWindowScene})
                           .compactMap({$0})
                           .first?.windows
                           .filter({$0.isKeyWindow}).first
                       keyWindow?.rootViewController = PYSTabBarController()
                    }else{
                       // Utility.showMsg(vc: self, title: "BlueWave", msgTxt: result)
                      // GlobalVariables.currentUserInfo.purchaseStatus = false
                        DispatchQueue.main.async {
                            let vc = ProfileInfoVC()
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            }
    }
    
    
    func RegisterDevice(){
        
        struct DeviceType:Codable{
            let deviceType:String?
            init(model:String) {
                deviceType = model
            }
        }
        
        let deviceType = DeviceType(model: UIDevice.modelName)
        
       let uid = Auth.auth().currentUser?.uid
       let ref = Firestore.firestore().collection("users").document(uid!)
       ref.getDocument { (document, error) in
         if let error = error {
             print(error.localizedDescription)

             return
           }
         do {
             try ref.setData(from: deviceType, merge: true)
            
         } catch {
             print(error.localizedDescription)
         }
       }
    }
    
    func getMemberShipInfo(){
        
        if Reachability.isConnectedToNetwork() {
            
            let db = Firestore.firestore()
            let docName = Auth.auth().currentUser?.uid ?? ""
            let ref = db.collection("users").document(docName)
            
            ref.getDocument {(document, error) in
                if let document = document, document.exists {
//                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                    print("Document data: \(dataDescription)")
//                    print("Okay")
                    do {
                        guard let userInfo: UserInfo = try document.data(as: UserInfo.self) else {return}
                        
                        GlobalVariables.currentUserInfo = userInfo
                    }catch{
                        
                    }
                      
                    
                } else {
                    print("Document does not exist")
                }
            }

          
        }
        else
        {
           print("No Internet")
        }
    }
    
    func setupUI(){

        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
       logoImagView.contentMode = .scaleAspectFit


        view.addSubview(buttonContainer)
        logoImagView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageWrapperView)
        imageWrapperView.translatesAutoresizingMaskIntoConstraints = false
        imageWrapperView.addSubview(logoImagView)
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
      
        
        buttonContainer.backgroundColor =  AppColors.MAINCOLOR
        buttonContainer.cornerRadius = 40
        

        let creatAccountBtn = CornerRadiusButton()
        creatAccountBtn.backgroundColor = AppColors.BTNCOLOR
        creatAccountBtn.titleLabel?.font = AppFonts.MAINFONT
        
        creatAccountBtn.setTitle("Create Acccount", for: .normal)
        creatAccountBtn.addTarget(self, action:#selector(GotoCreateAccount), for: .touchUpInside)
      
        let signBtn = CornerRadiusButton()
        signBtn.layer.borderWidth = 1
        signBtn.layer.borderColor = UIColor(hexString: "#EEEEEE").cgColor
        signBtn.setTitle("SignIn", for: .normal)
        signBtn.titleLabel?.font = AppFonts.MAINFONT
        
        signBtn.addTarget(self, action:#selector(GotoSignin), for: .touchUpInside)

        buttonContainer.addSubview(signBtn)
        buttonContainer.addSubview(creatAccountBtn)
        
        signBtn.translatesAutoresizingMaskIntoConstraints = false
        creatAccountBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageWrapperView.topAnchor.constraint(equalTo: view.topAnchor),
            imageWrapperView.bottomAnchor.constraint(equalTo: buttonContainer.topAnchor),
            imageWrapperView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageWrapperView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            buttonContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.47),
            logoImagView.centerXAnchor.constraint(equalTo: imageWrapperView.centerXAnchor),
            logoImagView.centerYAnchor.constraint(equalTo: imageWrapperView.centerYAnchor),

            logoImagView.heightAnchor.constraint(equalTo: logoImagView.widthAnchor, multiplier: 1),
            logoImagView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.36),
            signBtn.heightAnchor.constraint(equalToConstant: 48),
            signBtn.centerXAnchor.constraint(equalTo: buttonContainer.centerXAnchor),
            signBtn.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor),
            signBtn.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor, constant: 30),
            signBtn.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor, constant: -30),
            creatAccountBtn.heightAnchor.constraint(equalToConstant: 48),
            creatAccountBtn.bottomAnchor.constraint(equalTo: signBtn.topAnchor, constant: -16),
            creatAccountBtn.leadingAnchor.constraint(equalTo: signBtn.leadingAnchor),
            creatAccountBtn.trailingAnchor.constraint(equalTo: signBtn.trailingAnchor)
            
        ])
                
    }
    
    
    @objc func GotoSignin(sender: UIButton){
       
        let vc = SigninVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func GotoCreateAccount(sender: UIButton){
         
      let vc = SignupVC()
      self.navigationController?.pushViewController(vc, animated: true)
              
    }
   
}


//struct DebugVC:UIViewControllerRepresentable {
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<DebugVC>) -> DebugVC.UIViewControllerType {
//
//        return RootVC()
//    }
//
//    func updateUIViewController(_ uiViewController: RootVC, context: UIViewControllerRepresentableContext<DebugVC>) {
//
//    }
//}
//
//struct DebugView : View {
//    var body : some View{
//
//        DebugVC()
//    }
//}
//
//struct DebugPreview : PreviewProvider {
//    static var previews : some View{
//        DebugView()
//    }
//}

//struct RootVC_Previews: PreviewProvider {
//    static var previews: some View {
//        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//    }
//}
