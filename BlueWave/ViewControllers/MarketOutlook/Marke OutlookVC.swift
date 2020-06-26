//
//  marketOutlookVC.swift
//  BlueWave
//
//  Created by FreeBird on 4/18/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit
import LBTATools
import SideMenu



class MarketOutlookVC: UIViewController {
    
    var dataSrc:[MOLModel] = []
    let menu = SideMenuNavigationController(rootViewController: SideMenuVC())
    let tv = UITableView(psEnabled: false)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchLinks()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        view.fillSuperviewSafeAreaLayoutGuide()
        tv.delegate = self
        tv.dataSource = self
        
        view.backgroundColor = .white
        
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.rowHeight = UITableView.automaticDimension
        
        UIHelper.TransparentNavVC(vc: self)
        setupNavbar()
        setupUI()
        setupSideMenu()
        
        tv.register(MarketOutLookCell.self, forCellReuseIdentifier: "MarcketCell")
    }
    
    func fetchLinks(){
    
        NetWorkManager.shared.getMarketPlaceLinks { (result) in
            
            switch result{
            case.success(let result):
                self.dataSrc = result
                print(result)
                self.tv.reloadData()
            case.failure(let err):
                print(err.localizedDescription)
            }
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

            title.text = "Market Outlook"
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
            
    //         SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
    //
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
        
        container.addSubview(tv)
        
         NSLayoutConstraint.activate([

             container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             container.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.86),
             
             tv.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            tv.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            tv.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            tv.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.93)
        
             
         ])
    
    }

}

extension MarketOutlookVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSrc.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarcketCell" , for: indexPath) as! MarketOutLookCell
        
        cell.setVideo(obj: dataSrc[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }

}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct MarketOutlookVCViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let discoverNC = UINavigationController(rootViewController: MarketOutlookVC())
        return discoverNC.view
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct MarketOutlookVCViewController_Preview: PreviewProvider {
    static var previews: some View {
        MarketOutlookVCViewRepresentable()
        .previewDevice("iPhone 11 Pro Max")
        
    }
}
#endif
