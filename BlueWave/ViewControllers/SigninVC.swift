//
//  SigninVC.swift
//  BlueWave
//
//  Created by FreeBird on 4/12/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import SideMenu
import LBTATools
import FirebaseAuth
import SkyFloatingLabelTextField

class SigninVC: UIViewController {

    var container = UIStackView()
    var buttonContainer = SemiRadiusView()
    var logoImagView = UIImageView(image: #imageLiteral(resourceName: "finallogo"))
    let imageWrapperView = UIView(psEnabled: false)
    let needSupportLbl : UIButton = {
        let l = UIButton(psEnabled: false)
        return l
    }()
    
     let menu = SideMenuNavigationController(rootViewController: SideMenuVC())

    let emailTF :SkyFloatingLabelTextField = {
        
        let tf = SkyFloatingLabelTextField(psEnabled: false)
        tf.placeholder =  "Email"
        
        tf.textColor = .white
        tf.selectedLineColor = .white
        tf.tintColor = .white
        tf.titleColor = .gray
        tf.selectedTitleColor = .lightGray
        return tf
        
    }()
    
    let subContainer : UIView = {
        
        let v = UIView(psEnabled: false)
        return v
    }()

    
    let passwordTF : SkyFloatingLabelTextField = {
        
        let tf = SkyFloatingLabelTextField(psEnabled: false)
        tf.placeholder =  "Password"
        tf.isSecureTextEntry = true
        tf.textColor = .white
        tf.selectedLineColor = .white
        tf.tintColor = .white
        tf.titleColor = .gray
        tf.selectedTitleColor = .lightGray
               
        return tf
    }()
  

    let signBtn : CornerRadiusButton = {
        let b = CornerRadiusButton(psEnabled: false)
        b.backgroundColor = AppColors.BTNCOLOR
        b.setTitle("SignIn", for: .normal)
        b.titleLabel?.font = AppFonts.MAINFONT
        b.addTarget(self, action: #selector(login), for: .touchDown)
        
        return b

    }()
    
    
    let forgetBtn : CornerRadiusButton = {
       let b = CornerRadiusButton(psEnabled: false)
        b.setTitle("Forget Password?", for: .normal)
        b.setTitleColor(AppColors.BTNCOLOR, for: .normal)
        b.addTarget(self, action: #selector(forgetPwd), for: .touchDown)
        
        return b
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
   
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        
        

        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        safeAreaHeight = view.safeAreaInsets.bottom
        
//        IAPManager.shared.verifyPurchase(RegisteredPurchase.oneMonth) { (verifyResult, productIDs, true) in
//
//        }
        
    }
    
    
    
    
    func setupNavbar() {

        let menuItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .done, target: self, action: #selector(onTapMenu))
        let logoItem = UIBarButtonItem(image: #imageLiteral(resourceName: "logo2"), style: .done, target: self, action: #selector(onClickLogo))
        menuItem.tintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        logoItem.tintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        navigationItem.leftBarButtonItem = menuItem
        navigationItem.rightBarButtonItem = logoItem
    }

    @objc func onTapMenu() {
        present(menu, animated: true, completion: nil)
    }

    @objc func onClickLogo(){

    }

    private func setupSideMenu() {
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view, forMenu: .left)
        menu.statusBarEndAlpha = 0
        menu.menuWidth = view.frame.size.width
        menu.animationOptions = .allowUserInteraction
        menu.navigationBar.isHidden = true
        menu.presentationStyle = .menuSlideIn
    }
    
    
    func setupUI(){
        
        logoImagView.contentMode = .scaleAspectFit


       view.addSubview(buttonContainer)
       logoImagView.translatesAutoresizingMaskIntoConstraints = false
       view.addSubview(imageWrapperView)
       imageWrapperView.addSubview(logoImagView)
       buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        
       buttonContainer.backgroundColor = AppColors.MAINCOLOR
       buttonContainer.cornerRadius = 40
            
        needSupportLbl.setTitle("Need Support Help?", for: .normal)
        needSupportLbl.setTitleColor(AppColors.BTNCOLOR, for: .normal)
        needSupportLbl.titleLabel!.textAlignment = .center
        needSupportLbl.titleLabel!.font = AppFonts.MAINFONT
        needSupportLbl.addTarget(self, action: #selector(gotoSupport), for: .touchDown)

            
        buttonContainer.stack(UIView(),buttonContainer.stack(emailTF).padLeft(30).padRight(30),buttonContainer.stack(passwordTF).padLeft(30).padRight(30),buttonContainer.stack(signBtn,forgetBtn,spacing:3),UIView(),needSupportLbl, spacing: 10, alignment: .fill, distribution: .equalCentering).padLeft(20).padRight(20)
       
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
                   
                  
                    
                    signBtn.heightAnchor.constraint(equalToConstant: 48)
               ])

        
    }
    
    @objc func forgetPwd(){
        
    
         Utility.AskEmail(vc: self)
        
        
    }
    @objc func gotoSupport(){

        if let url = URL(string: Links.supportLink) {
                  UIApplication.shared.open(url)
        }
    }
    
    @objc  func login(){
        

//        let keyWindow = UIApplication.shared.connectedScenes
//                         .filter({$0.activationState == .foregroundActive})
//                         .map({$0 as? UIWindowScene})
//                         .compactMap({$0})
//                         .first?.windows
//                         .filter({$0.isKeyWindow}).first
//                     keyWindow?.rootViewController = PYSTabBarController()
        let progressbar = self.setProgressbar()
        progressbar.color = .black

         if ValidateFields() != nil {
                   Utility.showMsg(vc: self, title: "Blue Wave", msgTxt: "Please input correct information!")

         } else{

            progressbar.beginAnimation()
            Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { (result, err) in

                progressbar.endAnimation()
               var firebaseErrorMsgTxt: String = ""
               if err != nil{

                   if let errCode = AuthErrorCode(rawValue: err!._code) {

                      switch errCode {
                      case .emailAlreadyInUse:
                              firebaseErrorMsgTxt = "This email was used by others"
                      case .invalidEmail:
                              firebaseErrorMsgTxt = "Invalid email"
                      case.wrongPassword:
                           firebaseErrorMsgTxt = "Wrong Password!"

                      case.weakPassword:
                           firebaseErrorMsgTxt = "Weak Password"
                          default:
                           print("Create User Error: \(String(describing: err))")
                           firebaseErrorMsgTxt = "Your Eamil or Password is wrong"
                      }

                       progressbar.stopAnimating()
                       Utility.showMsg(vc: self, title: "Blue Wave", msgTxt: firebaseErrorMsgTxt)
                  }
               }else{

                   progressbar.stopAnimating()
                
                  
                if GlobalVariables.IAPflag{
                    
                    let vc = IntradaySignalVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    let vc = ProfileInfoVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                   
               }
            }
        }

    }
    
    
   func ValidateFields() -> String?{
      
      if emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
      {
          
          return "Error"
      }
      
      
      return nil
  }
      

}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct SigninVCRepresentable: UIViewControllerRepresentable {
    

    func makeUIViewController(context: Context) -> SigninVC{
        return SigninVC()
    }
    
    func updateUIViewController(_ uiViewController: SigninVC, context: Context) {
        
    }
}

@available(iOS 13.0, *)
struct SigninVCController_Preview: PreviewProvider {
    static var previews: some View {
        SigninVCRepresentable()
            .previewLayout(.sizeThatFits)
    }
}

#endif



