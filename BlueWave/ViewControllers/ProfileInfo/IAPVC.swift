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
import SwiftyStoreKit
import StoreKit


struct InAppModel{
    
    let id:String?
    var month : String = "6"
    var price : String = "269"
    var descript : String = ""
    
    init(model:PerchaseInfo) {

        price = "\(model.currencyType!)\(model.price! )"
        month = model.period ?? "1"
        
        print(RegisteredPurchase.sixMonth.rawValue)
        switch model.id! {
        case bundleID + "." + RegisteredPurchase.sixMonth.rawValue:
            descript = IAPDescriptions.sixMonth
        case bundleID + "." + RegisteredPurchase.threeMonth.rawValue:
            descript = IAPDescriptions.threeMonth
        case bundleID + "." + RegisteredPurchase.oneMonth.rawValue:
            descript = IAPDescriptions.oneMonth
    
        default:
            print("okay")
        }
       

        id = model.id
    }
}


enum CellID:String{
    case termsCell
}

class InAppVC: UIViewController{
   

    var dataSrc : [InAppModel] = []
    let tv = UITableView(psEnabled: false)
    let menu = SideMenuNavigationController(rootViewController: SideMenuVC())
   // let purchaseManager = PurchaseManager()
    var purchaseInfos:[PerchaseInfo] = []
    var fullPurchaseInfos:[SKProduct] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        IAPManager.shared.getInfo() { (result) in
            
            switch result{
            case.success(let responds):
                
                let productInfos = responds.retrievedProducts
              //  self.fullPurchaseInfos = productInfos
                self.fullPurchaseInfos.removeAll()
                self.purchaseInfos.removeAll()
                for productInfo in productInfos{
                    
                    let item = PerchaseInfo(model: productInfo)
                    self.purchaseInfos.append(item)
                    self.fullPurchaseInfos.append(productInfo)
                }

                self.initDataSrc()
                self.tv.reloadData()
                
                
            case.failure(let err):
                
                print(err.localizedDescription)
       
            
            }
            
            
        }
        
   
        
        view.backgroundColor = .white
        
        tv.dataSource = self
        tv.delegate = self
        UIHelper.TransparentNavVC(vc: self)
        setupNavbar()
        setupUI()
        setupSideMenu()
        tv.rowHeight = UITableView .automaticDimension
        tv.estimatedRowHeight = 400
        tv.register(termsCell.self, forCellReuseIdentifier: CellID.termsCell.rawValue )
        

    
    }
    
    
    func initDataSrc(){
        
        
        dataSrc.removeAll()
        purchaseInfos.sort{$0.period! > $1.period!}
        fullPurchaseInfos.sort{$0.price.intValue>$1.price.intValue}
        
        for perchas in purchaseInfos{
            
            print(perchas)
            let item = InAppModel(model: perchas)
            dataSrc.append(item)
        }
        
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
            SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view, forMenu: .left)
            menu.statusBarEndAlpha = 0
            menu.menuWidth = view.frame.size.width
            menu.animationOptions = .allowUserInteraction
            menu.navigationBar.isHidden = true
            menu.presentationStyle = .menuSlideIn
        }

        
       func setupUI(){
         
         let container = SemiRadiusView()
        // container.backgroundColor = AppColors.GREYBGCOLOR

             view.addSubview(container)

        container.translatesAutoresizingMaskIntoConstraints = false
        
         NSLayoutConstraint.activate([

             container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             container.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.86),
             
         ])
        tv.separatorStyle = .none
        container.addSubview(tv)
        tv.backgroundColor = .clear
        tv.fillSuperview()

    }

}


extension InAppVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if dataSrc.count  == 0{
            return 0
        }
        return dataSrc.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row<3{
            
           let cell = InAppCell()
           cell.setDataCell(obj: dataSrc[indexPath.row])
           cell.callback = {
                
                let product:SKProduct = self.fullPurchaseInfos[indexPath.row]
                IAPManager.shared.purchaseProduct(with: product) { (success,msg, result) in
                    
                    if success{
                        
                        GlobalVariables.IAPflag = true
                        
                        Utility.showMsgForResult(vc: self, title: "BlueWave", msgTxt: "Successfully purchased!")

                    }else{
                        GlobalVariables.IAPflag = false
                        
                        Utility.showMsgForResult(vc: self, title: "BlueWave", msgTxt: msg ?? "Something went wrong ...")

                    }

                }
            }
            
           return cell
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.termsCell.rawValue, for: indexPath) as! termsCell
            
            cell.delegatge = self
        
            return cell
        }
       
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        320
    }

    
    
}


extension InAppVC:TermsCellDelegate{
    
    func tryRestoreIAP() {
        
        IAPManager.shared.restore { (result) in
            
            switch result{
                
            case.success(let respond):
                print(respond.restoredPurchases)
                if respond.restoredPurchases.count == 0{
                    GlobalVariables.IAPflag = true
                }else{
                    GlobalVariables.IAPflag = true
                }
            case.failure(let err):
                print(err.localizedDescription)
                
                GlobalVariables.IAPflag = false
            }
        
        }
    }
    
    
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct InAppViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let discoverNC = UINavigationController(rootViewController: InAppVC())
        return discoverNC.view
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct InAppVCViewController_Preview: PreviewProvider {
    static var previews: some View {
        InAppViewRepresentable()
        .previewDevice("iPhone SE")
        
    }
}
#endif
