//
//  ProfileInfoVC.swift
//  BlueWave
//
//  Created by FreeBird on 4/18/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//
import UIKit
import SideMenu
import LBTATools
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct UpdateCellId {
    static let UpdateInfoCell: String = "updateinfocell"
    static let ProfileHeader: String = "profileheader"
}

class UpdateVC:UIViewController{
    

    let imagePicker = UIImagePickerController()
    let tv = UITableView(psEnabled: false)
    let menu = SideMenuNavigationController(rootViewController: SideMenuVC())
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.backgroundColor = .white
        tv.dataSource = self
        tv.delegate = self
        tv.allowsSelection = false
        UIHelper.TransparentNavVC(vc: self)
        setupNavbar()
        setupUI()
        setupSideMenu()
        imagePicker.delegate = self
        tv.register(ProfileHeader.self, forHeaderFooterViewReuseIdentifier: UpdateCellId.ProfileHeader)
        tv.register(UpdateInfoCell.self, forCellReuseIdentifier: UpdateCellId.UpdateInfoCell)
        
    }
    

    func setupNavbar() {

            let menuItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .done, target: self, action: #selector(onTapMenu))
            let logoItem = UIBarButtonItem(image: #imageLiteral(resourceName: "logo2"), style: .done, target: self, action: #selector(onClickLogo))
            menuItem.tintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            logoItem.tintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            navigationItem.leftBarButtonItem = menuItem
            navigationItem.rightBarButtonItem = logoItem

            let title : UILabel = {
            let l = UILabel()
            l.font = UIFont(name: AppFontNames.InterRegular, size: 22)
            return l
            }()

            title.text = "Profile"
            navigationItem.titleView = title

            }
          
        
        @objc func onTapMenu() {
            present(menu, animated: true, completion: nil)
        }
        @objc func onClickLogo() {
            present(menu, animated: true, completion: nil)
        }

        
        private func setupSideMenu() {
            
             SideMenuManager.default.leftMenuNavigationController = menu
            
             SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
                SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view, forMenu: .left)
                menu.statusBarEndAlpha = 0
                menu.menuWidth = view.frame.size.width
                menu.animationOptions = .allowUserInteraction
                menu.navigationBar.isHidden = true
                menu.presentationStyle = .menuSlideIn
        }

       func setupUI(){
         
         let container = SemiRadiusView()
         container.backgroundColor = AppColors.GREYBGCOLOR
             container.cornerRadius = 60
             view.addSubview(container)

        container.translatesAutoresizingMaskIntoConstraints = false
        
         NSLayoutConstraint.activate([

             container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             container.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.86),
             
         ])
        
        container.addSubview(tv)
        tv.backgroundColor = .clear
        tv.fillSuperview()
        self.tabBarController?.tabBar.isHidden = true
    }
    
  

}


extension UpdateVC : UITableViewDelegate, UITableViewDataSource{

    func trytoUpdateProfile(currentEmail:String,username:String, phonenumber:String) {

        let progressbar = self.setProgressbar()
        progressbar.color = .black
        progressbar.beginAnimation()
        Auth.auth().currentUser?.updateEmail(to: currentEmail, completion: {(error) in
            
            if error != nil{
                progressbar.endAnimation()
                let msgTxt = Utility.FirebaseErrAnalysis(err: error)
                Utility.showMsg(vc: self, title: "Blue Wave", msgTxt: msgTxt)
            }else{
                
               let db = Firestore.firestore()
               let usersDb = db.collection("users")
                 let userData = [
                   "email" : currentEmail,
                   "name": username,
                   "udid" : Auth.auth().currentUser?.uid,
                   "phonenumber" : phonenumber,
                   "imageLink" : GlobalVariables.currentUserInfo.imageLink
                 ]
               guard let uid = Auth.auth().currentUser?.uid else { return }
               let userDoc = usersDb.document(uid)
               userDoc.setData(userData as [String : Any], merge: true){
                   (error) in
                   
                   if error != nil {
                       
                        progressbar.endAnimation()
                        Utility.showMsg(vc: self, title: "Firebase", msgTxt: "Failed in Sign up")
                   } else {
                        
                        progressbar.endAnimation()
                        Utility.showMsg(vc: self, title: "Firebase", msgTxt: "Successfully updated your profile!")
                    
                    GlobalVariables.currentUserInfo.name = username
                   }
               }
                
            }
            
        })
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UpdateCellId.UpdateInfoCell, for: indexPath) as! UpdateInfoCell
   //    cell.delegate = self
        
        cell.callback = {
        
            self.trytoUpdateProfile(currentEmail: cell.emailLbl.text!, username: cell.nameLbl.text!, phonenumber: cell.phoneNumberLbl.text!)
            
        }
        cell.setDataHere(obj: GlobalVariables.currentUserInfo)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
  
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: UpdateCellId.ProfileHeader) as! ProfileHeader
        
        cell.setUserImage(imgLink: GlobalVariables.currentUserInfo.imageLink)
        cell.callback = {
        
            self.importPhoto()
        }

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        200
    }
    
   
    func importPhoto(){
          

          imagePicker.sourceType = .photoLibrary
          
          imagePicker.allowsEditing = true
          
          self.present(imagePicker, animated: true)
          {
              //After it is complete
          }
          
      }
    
}

extension UpdateVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage
        {
            uploadImage(img: image)
        }else{
            print("Error")
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
  func uploadImage(img:UIImage){
        
        guard let data = img.jpegData(compressionQuality: 1.0) else {
            
            Utility.showMsgForResult(vc: self, title: "Blue Wave", msgTxt: "Something went wrong")
            return
        }
    
        let progressbar = self.setProgressbar()
        progressbar.color = .black
        progressbar.beginAnimation()
        
        let imageName = UUID().uuidString
        let imageReference = Storage.storage().reference()
            .child(GlobalVariables.usersImageFolder)
            .child(imageName)
        
        imageReference.putData(data, metadata: nil) { (metadata, error) in
            
            if error != nil{
                
                Utility.showMsgForResult(vc: self, title: "Blue Wave", msgTxt:error!.localizedDescription)
                return
            }
            
            imageReference.downloadURL { (url, err) in
                
                if error != nil{
                    
                    Utility.showMsgForResult(vc: self, title: "Blue Wave", msgTxt: error!.localizedDescription)
                    
                    return
                }
                
                guard url != nil else{
                 
                    Utility.showMsgForResult(vc: self, title: "Blue Wave", msgTxt: "Something went Wrong")
                    return
                }
                
                GlobalVariables.currentUserInfo.imageLink = url!.absoluteString
                self.tv.reloadData()
                
                progressbar.endAnimation()
            }
            
        }
        
        
    }
}




#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct UpdateVCViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let discoverNC = UINavigationController(rootViewController:
            UpdateVC())
        return discoverNC.view
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct UpdateVCViewController_Preview: PreviewProvider {
    static var previews: some View {
        
    return Group {
        UpdateVCViewRepresentable().previewDevice( "iPhone X").edgesIgnoringSafeArea(.all)
        UpdateVCViewRepresentable().previewDevice("iPhone 8").edgesIgnoringSafeArea(.all)
        UpdateVCViewRepresentable().previewDevice("iPhone 6s").edgesIgnoringSafeArea(.all)
        }
    }
}
#endif

