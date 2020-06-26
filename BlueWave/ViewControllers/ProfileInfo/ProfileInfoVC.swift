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

class ProfileInfoVC: UIViewController,ProfileInfoCellDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
   
    let vm = ProfileInfoVM()
    
    func checkingUser(){
        Utility.AskPassword(vc: self)
    }
    
    @objc func gotoUpdateVC() {
        
        let vc = UpdateVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoInAppVC() {
        
        let vc = InAppVC()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    let tv = UITableView(psEnabled: false)

    let menu = SideMenuNavigationController(rootViewController: SideMenuVC())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        tv.register(ProfileInfoCell.self, forCellReuseIdentifier: "InfoCell")
      //  getPurchaseInfo()
        vm.getUserInfo { (success, result) in
            
            if success {
                print("Ok")
                DispatchQueue.main.async {
                    self.tv.reloadData()
                }
           
                
            }else{
                print(result)
            }
        }
        view.backgroundColor = .white
        tv.allowsSelection = false
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        tv.dataSource = self
        tv.delegate = self
        UIHelper.TransparentNavVC(vc: self)
        setupNavbar()
        setupUI()
        setupSideMenu()
        
        NotificationCenter.default.addObserver(self, selector: #selector(gotoUpdateVC), name: NSNotification.Name(rawValue: "checked"), object: nil)
        
        self.tabBarController?.tabBar.isHidden = true    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)

        
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

    }

}


extension ProfileInfoVC : UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! ProfileInfoCell
        
        cell.setDataHere(obj: vm.fullUserInfo)
        cell.delegate = self
     
        
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = ProfileHeader()
        
        cell.setUserImage(imgLink: vm.fullUserInfo.imageLink)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        200
    }
    
    
    
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ProfileInfoVCViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let discoverNC = UINavigationController(rootViewController: ProfileInfoVC())
        return discoverNC.view
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct ProfileInfoVCViewController_Preview: PreviewProvider {
    static var previews: some View {
        ProfileInfoVCViewRepresentable()
        .previewDevice("iPhone SE")
        
    }
}
#endif
