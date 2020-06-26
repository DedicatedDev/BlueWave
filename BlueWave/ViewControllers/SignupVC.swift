//
//  SignupVC.swift
//  BlueWave
//
//  Created by FreeBird on 4/12/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit
import SwiftUI
import LBTATools
import SkyFloatingLabelTextField
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignupVC: UIViewController{

    var fieldFlag:Bool = false
    lazy var scrollView: UIScrollView = {
           let sv = UIScrollView()
           sv.translatesAutoresizingMaskIntoConstraints = false
           sv.showsHorizontalScrollIndicator = false
           sv.contentInsetAdjustmentBehavior = .never
           sv.isScrollEnabled = true
           sv.bounces = false
           return sv
       }()
    
    let contentView = UIView(psEnabled: false)
    
    let titleLbl : UILabel = {
        
        let l = UILabel(psEnabled: false)
        l.text = "Create Account"
        l.font = AppFonts.TitleFONT
        l.textAlignment = .center
        l.textColor = .white
        return l
        
    }()

     
    let topSpacer = UILabel(psEnabled: false)
    
    let usernameTF : SkyFloatingLabelTextField = {
        
        let tf = SkyFloatingLabelTextField(psEnabled: false)
        tf.placeholder = "UserName"
        
        tf.textColor = .white
        tf.selectedLineColor = .white
        tf.tintColor = .white
        tf.titleColor = .gray
        tf.selectedTitleColor = .lightGray
    
        
        return tf
    }()
    
 
//    var username: String {
//
//        guard let s = usernameTF.text else {
//            print( "No name to submit")
//            return ""
//        }
//        return s
//    }
//
//    var userPhonenumber:String{
//
//        guard let n = userPhonenumberTF.text else {
//            return ""
//        }
//        return n
//    }
//
//    var userEmail:String{
//        guard let e = userEmailTF.text else {
//
//            return ""
//        }
//        return e
//    }
//
//    var passcode:String{
//        guard let p = userPasswordTF.text else {
//
//            return ""
//        }
//
//        return p
//    }
//
//    var country:String{
//        guard let c = countryDropdownMenu.text else {
//
//            return ""
//        }
//
//        return c
//    }
//
//    var city:String{
//        guard let ci = cityDropdownMenu.text else {
//
//            return ""
//        }
//        return ci
//    }
//
//    var address:String{
//        guard let ad = addressTF.text else {
//
//            return ""
//        }
//        return ad
//    }
//
    let userPhonenumberTF : SkyFloatingLabelTextField = {
       
        let tf = SkyFloatingLabelTextField(psEnabled: false)
        tf.placeholder = "Phone Number"
        tf.keyboardType = UIKeyboardType.phonePad
        tf.textContentType = .telephoneNumber
        
        tf.textColor = .white
        tf.selectedLineColor = .white
        tf.tintColor = .white
        tf.titleColor = .gray
        tf.selectedTitleColor = .lightGray
        
        return tf
        
    }()
 
          
    let userEmailTF : SkyFloatingLabelTextField = {
        
        let tf = SkyFloatingLabelTextField(psEnabled: false)
        tf.placeholder = "Email"
        tf.textContentType = .emailAddress
        tf.keyboardType = .emailAddress
        
        tf.textColor = .white
        tf.selectedLineColor = .white
        tf.tintColor = .white
        tf.titleColor = .gray
        tf.selectedTitleColor = .lightGray
        
        return tf
    }()
   
            
    let userPasswordTF : SkyFloatingLabelTextField = {
        
        let tf = SkyFloatingLabelTextField(psEnabled: false)
        tf.placeholder = "Password"
        tf.textContentType = .password
        tf.isSecureTextEntry = true
        
        tf.textColor = .white
        tf.selectedLineColor = .white
        tf.tintColor = .white
        tf.titleColor = .gray
        tf.selectedTitleColor = .lightGray
        
        return tf
    }()
   
            
    let confirmPasswordTF : SkyFloatingLabelTextField = {
        
        let tf = SkyFloatingLabelTextField(psEnabled: false)
        tf.placeholder = "Confirm Password"
        tf.textContentType = .password
        tf.isSecureTextEntry = true
        
        tf.textColor = .white
        tf.selectedLineColor = .white
        tf.tintColor = .white
        tf.titleColor = .gray
        tf.selectedTitleColor = .lightGray
        
        return tf
    }()
       
            
    let countryDropdownMenu : DropDown = {
        
        let tf = DropDown(psEnabled: false)
        tf.placeholder = "Country"
        tf.arrowColor = .white
        let sortedKeys = Array(GlobalVariables.LocationInfo.keys).sorted(by: <)
        tf.optionArray = Array(sortedKeys)
        tf.isSearchEnable = true
        
        tf.textColor = .white
        tf.selectedLineColor = .white
        tf.tintColor = .white
        tf.titleColor = .gray
        tf.selectedTitleColor = .lightGray
        
        return tf
    }()
    
         
    let cityDropdownMenu : DropDown = {
        
        let tf = DropDown(psEnabled: false)
        tf.placeholder = "City"
        tf.arrowColor = .white
        tf.optionArray = Array(GlobalVariables.LocationInfo["Albania"]!)
        
        tf.textColor = .white
        tf.selectedLineColor = .white
        tf.tintColor = .white
        tf.titleColor = .gray
        tf.selectedTitleColor = .lightGray
        return tf
    }()
   
    let addressTF : SkyFloatingLabelTextField = {
        
        let tf = SkyFloatingLabelTextField(psEnabled: false)
        tf.placeholder = "Address"
        
        tf.textColor = .white
        tf.selectedLineColor = .white
        tf.tintColor = .white
        tf.titleColor = .gray
        tf.selectedTitleColor = .lightGray
        
        return tf
        
    }()
    

    let nextBtn : CornerRadiusButton = {
        
        let b = CornerRadiusButton(psEnabled: false)
        b.setTitle(AppTitles.NEXTBTNTEXT, for: .normal)
        b.titleLabel?.font = AppFonts.MAINFONT
        b.backgroundColor = AppColors.GREYBGCOLOR
        b.addTarget(self,action: #selector(NextClick), for: .touchUpInside)
        
        return b
    }()
   
           
            
    let needHelpLbl : UILabel = {
        let l = UILabel(psEnabled: false)
        l.textAlignment = .center
        l.text = AppTitles.NEEDHELPTEXT
        l.textColor = AppColors.BTNCOLOR
        
        return l
    }()
   
    let agreeBtn:UISwitch = {
        let l = UISwitch(psEnabled:  false)
        l.backgroundColor = AppColors.BTNCOLOR
        return l
    }()
    
    let termsLbl : UITextView = {
        
        let l = UITextView(psEnabled: false)
        l.textAlignment = .justified
       
        let description = NSMutableAttributedString(string: "I agree Blue wave's ")
        
        let supportLink = NSMutableAttributedString(string: "Terms of Service")
        supportLink.addAttribute(.link, value: Links.supportLink, range:NSRange(location: 0, length: supportLink.length))
        
        let privacyLink = NSMutableAttributedString(string: "Privacy Policy")
        privacyLink.addAttribute(.link, value: Links.termsLink, range: NSRange(location: 0, length: privacyLink.length))
        let and = NSMutableAttributedString(string: " and ")
        
        description.append(supportLink)
        description.append(and)
        description.append(privacyLink)
        l.attributedText = description
        l.textAlignment = .justified
        l.backgroundColor = .clear
         l.font = UIFont(name: AppFontNames.InterRegular, size: 16)
        
        return l
        
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(false, animated: false)
         UIHelper.TransparentNavVC(vc: self)
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        setupNavbar()
        setupUI()
        
        usernameTF.delegate = self
        userPasswordTF.delegate = self
        userPhonenumberTF.delegate = self
        userEmailTF.delegate = self
        countryDropdownMenu.delegate = self
        confirmPasswordTF.delegate = self
        cityDropdownMenu.delegate = self
        addressTF.delegate = self
        
        let termsStack = UIStackView(arrangedSubviews: [agreeBtn,termsLbl])
        termsStack.axis = .horizontal
        termsStack.spacing = 8
        
        
        countryDropdownMenu.didSelect{(selectedText , index ,id) in
            self.cityDropdownMenu.optionArray = GlobalVariables.LocationInfo["\(selectedText)"]!
        }
                   
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        safeAreaHeight = view.safeAreaInsets.bottom
    }
    

    func setupNavbar() {

        let menuItem = UIBarButtonItem(image: #imageLiteral(resourceName: "backBtnImg"), style: .done, target: self, action: #selector(onTapMenu))
        let logoItem = UIBarButtonItem(image: #imageLiteral(resourceName: "logo2"), style: .done, target: self, action: #selector(onClickLogo))
        menuItem.tintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        logoItem.tintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        navigationItem.leftBarButtonItem = menuItem
        navigationItem.rightBarButtonItem = logoItem

    }

    @objc func onTapMenu() {

        self.navigationController?.popViewController(animated: true)
    }

    @objc func onClickLogo(){

    }
    
    func setupUI(){
        
        let container = SemiRadiusView()
        container.backgroundColor = AppColors.MAINCOLOR
        container.cornerRadius = 40
        contentView.addSubview(container)
        scrollView.addSubview(contentView)
        contentView.fillSuperview()
    
    
        container.stack(topSpacer,
                        titleLbl,
                        usernameTF,
                        userPhonenumberTF,
                        userEmailTF,
                        userPasswordTF,
                        confirmPasswordTF,
                        countryDropdownMenu,
                        cityDropdownMenu,
                        addressTF,
                        nextBtn.withHeight(48),
                        needHelpLbl, spacing:30, alignment: .fill, distribution: .equalSpacing).padBottom(5).padRight(20).padLeft(20)
        

        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.86),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

        ])
        
        
        let heightAncher = scrollView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
           
           heightAncher.priority = UILayoutPriority(250)
           heightAncher.isActive = true
    }
    
    
    @objc func NextClick(){
        
        Spinner.start()
        Auth.auth().createUser(withEmail: userEmailTF.text!, password: userPasswordTF.text!) { (result, err) in
            Spinner.stop()
               if let err = err {
                
                   let msg: String = Utility.FirebaseErrAnalysis(err: err)
                   Utility.showMsg(vc: self, title: "Firebase", msgTxt: msg)
                 

               } else {
                       
                   let db = Firestore.firestore()
                   let usersDb = db.collection("users")
                     let userData = [
                        "email":self.userEmailTF.text!,
                       "name": self.usernameTF.text!,
                       "udid" : result!.user.uid,
                       "imageLink":"",
                       "phonenumber" : self.userPhonenumberTF.text!,
                       "country" : self.countryDropdownMenu.text!,
                       "city" : self.cityDropdownMenu.text!,
                       "address" : self.addressTF.text!
                     ]
                   guard let uid = Auth.auth().currentUser?.uid else { return }
                   let userDoc = usersDb.document(uid)
                   userDoc.setData(userData){
                       (error) in
                       
                       if error != nil {
                           
                           Utility.showMsg(vc: self, title: "Firebase", msgTxt: "Failed in Sign up")
                       } else {
                            self.GotoHomeVC()
                       }
                       
                   }
               }
           }
        
        
        
    }
    
    func GotoHomeVC(){
        
//        let vc = HomeVC()
//        navigationController?.pushViewController(vc, animated: true)
        
        let vc = ProfileInfoVC()
        navigationController?.pushViewController(vc, animated: true)
        
//        let keyWindow = UIApplication.shared.connectedScenes
//                                     .filter({$0.activationState == .foregroundActive})
//                                     .map({$0 as? UIWindowScene})
//                                     .compactMap({$0})
//                                     .first?.windows
//                                     .filter({$0.isKeyWindow}).first
//                                 keyWindow?.rootViewController = PYSTabBarController()
    }

}


extension SignupVC:UITextFieldDelegate{
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if ValidateFields() != nil {
            
            nextBtn.isUserInteractionEnabled = false
            
            
        }else if ValidateFields() == "incorrectpassword"{
            
            Utility.showMsg(vc: self, title: "Blue Wave", msgTxt: "Please confirm password again")
            
        }else if ValidateFields() == "incorrectphonenumber"{
             Utility.showMsg(vc: self, title: "Blue Wave", msgTxt: "Please input correct phone number again")
        }else{
            
            nextBtn.isUserInteractionEnabled = true
            nextBtn.backgroundColor = AppColors.BTNCOLOR
        }
        
    }
    
     func ValidateFields() -> String?{
  
        if usernameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || userEmailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || userPhonenumberTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || userPasswordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || confirmPasswordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || countryDropdownMenu.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || cityDropdownMenu.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || addressTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            
            return "Error"
        }
        
        if userPasswordTF.text != confirmPasswordTF.text {
            
            return "incorrectpassword"
        }
        
        if !Utility.isValidPhone(phone: userPhonenumberTF.text!){

            return "incorrectphonenumber"
        }
        

        return nil
    }
    
   
    

    
}



#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct SignUpVCRepresentable: UIViewControllerRepresentable {
    

    func makeUIViewController(context: Context) -> SignupVC{
        return SignupVC()
    }
    
    func updateUIViewController(_ uiViewController: SignupVC, context: Context) {
        
    }
}

@available(iOS 13.0, *)
struct ChefVCController_Preview: PreviewProvider {
    static var previews: some View {
        SignUpVCRepresentable()
//            .previewLayout(.sizeThatFits)
        .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
    }
}

#endif
