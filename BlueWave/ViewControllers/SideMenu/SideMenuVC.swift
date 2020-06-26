//
//  SideMenuVC.swift
//  BlueWave
//
//  Created by FreeBird on 4/13/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit
import SwiftUI
import LBTATools
import SDWebImage
import FirebaseAuth

struct CellId{
    static let ProfileCellId : String = "profileCell"
    static let MenuItemCell : String = "menuitemCell"
}
class SideMenuVC: UIViewController {
    
    let viewModel = SideMenuViewModel()
    let tableView  = UITableView(psEnabled: false)
        
    var userInfo = GlobalVariables.currentUserInfo
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(ProfileTCell.self, forCellReuseIdentifier: CellId.ProfileCellId)
        tableView.register(SideMenuItemTCell.self, forCellReuseIdentifier: CellId.MenuItemCell)
 
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        userInfo = GlobalVariables.currentUserInfo
        //tableView.reloadData()
    }
    
    
    func setupUI(){
        
        tableView.backgroundColor = .white
        let closeBtn   = UIButton(psEnabled: false)
        closeBtn.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeSideMenu), for: .touchDown)
        
        let spacer1 = UILabel()
        let spacer2 = UILabel()
        view.stack(tableView,view.hstack(spacer1,closeBtn,spacer2,distribution: .equalSpacing), spacing: 10, alignment: .fill, distribution: .fill).padTop(44)
        
    }
    
    @objc func closeSideMenu(){
        
        self.dismiss(animated: true, completion: nil)
    }


}

extension SideMenuVC:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.numberOfItemAtSection(index: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()

        cell.backgroundColor = .red
        
        if indexPath.section == 0 && indexPath.row == 0 {
            
            let tempCell = tableView.dequeueReusableCell(withIdentifier: CellId.ProfileCellId, for: indexPath) as! ProfileTCell
            
            tempCell.setDataHere(obj: userInfo)
            
            cell = tempCell
        }else{
            let tempCell = tableView.dequeueReusableCell(withIdentifier: CellId.MenuItemCell, for: indexPath) as! SideMenuItemTCell
            
            viewModel.setDataToSideMenuCell(cell: tempCell, section: indexPath.section, index: indexPath.row)
            cell = tempCell
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        
        var titleText :String = ""
        switch section {
        case 1:
            titleText = "ACCOUNTS"
        case 2:
            titleText = "APPS"
        default:
            print("oka")
        }
        
        return titleText
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height: CGFloat = MenuItemHight.GENERALITEM
        
        if indexPath.section == 0 && indexPath.row == 0 {
            height = MenuItemHight.PROFILEITEM
        }
       
        return height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        tableView.tableHeaderView?.backgroundColor = .white
        
        return MenuItemHight.HEADERITEM
    }
    
      func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .white
            headerView.backgroundView?.backgroundColor = .black
            headerView.textLabel?.textColor = .black
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return viewModel.numberOfSetion()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        menuIndexClicked(indexPath: indexPath)
    }
    

    func menuIndexClicked(indexPath:IndexPath){
        
        switch indexPath.section {
         
          case 1:
              
              switch indexPath.row {
              case 0:
                
                if GlobalVariables.IAPflag{
                    
                    GlobalVariables.selectedSignalSrc = DataSrcType.INTRADAYSIGNAL
                     let vc  = SignalVC()
                       vc.viewTitle = "Intraday Signal"
                    
                    let keyWindow = UIApplication.shared.connectedScenes
                                    .filter({$0.activationState == .foregroundActive})
                                    .map({$0 as? UIWindowScene})
                                    .compactMap({$0})
                                    .first?.windows
                                    .filter({$0.isKeyWindow}).first
                                keyWindow?.rootViewController = PYSTabBarController()
               
                }else{
                    
                    let alert = UIAlertController(title: title, message: "Do you want to upgrade the premium?", preferredStyle: .alert)

                    
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                
                        self.dismiss(animated: true, completion: nil)
                        
                    }))
                    
                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
                        
                        let vc = InAppVC()
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }))
         
                     
                     self.present(alert, animated: true)

                }
                

              case 1:
                
                
                if GlobalVariables.IAPflag{
                       GlobalVariables.selectedSignalSrc = DataSrcType.SWINGSIGNAL
                      
                          let keyWindow = UIApplication.shared.connectedScenes
                                        .filter({$0.activationState == .foregroundActive})
                                        .map({$0 as? UIWindowScene})
                                        .compactMap({$0})
                                        .first?.windows
                                        .filter({$0.isKeyWindow}).first
                                    keyWindow?.rootViewController = PYSTabBarController()
                   }else{
                       
                       let alert = UIAlertController(title: title, message: "Do you want to upgrade the premium?", preferredStyle: .alert)

                       
                       alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                   
                           self.dismiss(animated: true, completion: nil)
                           
                       }))
                       
                       alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
                           
                           let vc = InAppVC()
                           self.navigationController?.pushViewController(vc, animated: true)
                           
                       }))
            
                        self.present(alert, animated: true)
                   }
                
            

              case 2:
                  
                let vc = MarketOutlookVC()
                self.navigationController?.pushViewController(vc, animated: true)
              default:
                  print("finished")
              }
              
              
          case 2:
              
              switch indexPath.row {
              case 0:
                  
//                if let url = URL(string: Links.supportLink) {
//                                 UIApplication.shared.open(url)
//                       }
                let vc = SupportVC()
                navigationController?.pushViewController(vc, animated: true)
                
              case 1:
                let vc = ProfileInfoVC()
                navigationController?.pushViewController(vc, animated: true)
              case 2:
                
                try! Auth.auth().signOut()
                
                GlobalVariables.currentUserInfo = UserInfo()
                let vc = RootVC()
                navigationController?.pushViewController(vc, animated: true)
                
               
              default:
                  print("finish")
              }
              
          default:
              print("total finish")
        
            
        }
        
      
    }
  
}


struct DebugVC:UIViewControllerRepresentable {

    func makeUIViewController(context: UIViewControllerRepresentableContext<DebugVC>) -> DebugVC.UIViewControllerType {
        return SideMenuVC()
    }

    func updateUIViewController(_ uiViewController: SideMenuVC, context: UIViewControllerRepresentableContext<DebugVC>) {
    }
}

#if DEBUG
struct DebugView : View {
    var body : some View{

        DebugVC()
    }
}

struct DebugPreview : PreviewProvider {
    static var previews : some View{
        DebugView().edgesIgnoringSafeArea(.all)
    }
}

#endif
