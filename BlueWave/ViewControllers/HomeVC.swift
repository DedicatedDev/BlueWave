//
//  HomeVC.swift
//  BlueWave
//
//  Created by FreeBird on 4/13/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit
import SwiftUI
import LBTATools
import SideMenu

class HomeVC: UIViewController {

    var viewModel  = HomeViewModel()
    var profileinfoVM = ProfileInfoVM()
    
    var  menu = SideMenuNavigationController(rootViewController: SideMenuVC())
    let currencyList = UITableView(psEnabled: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        UIHelper.TransparentNavVC(vc: self)
        currencyList.delegate = self
        currencyList.dataSource = self
        viewModel.getCrryExRateList()

        setupNavbar()
        setupUI()
        setupSideMenu()
        
        view.backgroundColor = .white
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        profileinfoVM.getUserInfo { (success, msg) in
            
            if success{
                GlobalVariables.currentUserInfo = self.profileinfoVM.fullUserInfo
                
           //     self.menu = SideMenuNavigationController(rootViewController: SideMenuVC())
                
            }else{
                print("error")
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

           title.text = "Home"
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
            SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
            SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view, forMenu: .left)
            menu.statusBarEndAlpha = 0
            menu.menuWidth = view.frame.size.width
            menu.animationOptions = .allowUserInteraction
            menu.navigationBar.isHidden = true
            menu.presentationStyle = .menuSlideIn
    }

    func setupUI(){
        
        let container = SemiRadiusView(psEnabled: false)
        container.backgroundColor = AppColors.GREYBGCOLOR
            container.cornerRadius = 60
            view.addSubview(container)

        currencyList.backgroundColor = .none
        currencyList.separatorColor = .gray
      //  container.addSubview(currencyList)
  
        container.stack(container.hstack(UIView(),
                                         container.stack(currencyList).withWidth(230),
                                         UIView(),distribution:.equalCentering)).padTop(20).padBottom(50)
        
        NSLayoutConstraint.activate([

            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.86),
            
//            currencyList.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -50),
//            currencyList.centerXAnchor.constraint(equalTo: container.centerXAnchor),
//            currencyList.topAnchor.constraint(equalTo: container.topAnchor, constant: 30),
//            currencyList.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.6)
            
        ])
        

        
    }
}

extension HomeVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.numberOfItem()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.crryExRateList[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = AppFonts.MAINFONT
        
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = AppColors.GREYBGCOLOR
        let titleView = UILabel()
        titleView.text = AppTitles.ChoosePairText
        titleView.textAlignment = .center
        titleView.font = AppFonts.SUBTITLFONT
        titleView.textColor = .black
        titleView.backgroundColor = .clear
        
        let subtitleView = UILabel()
        subtitleView.font = AppFonts.MAINFONT
        subtitleView.text = AppTitles.ChoosePairSubText
        subtitleView.textAlignment = .center
        subtitleView.textColor = .black
        subtitleView.backgroundColor = .clear
        
        headerView.stack(headerView.stack(titleView).padBottom(-10),headerView.stack(subtitleView).padTop(-10), spacing: 0, alignment: .fill, distribution: .fill).padTop(10).padBottom(10)
        
        
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        80
    }
    
    
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct HomeVCRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        
        let discoverNC = UINavigationController (rootViewController: HomeVC())
        return discoverNC.view
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct HomeVC_Preview: PreviewProvider {
    static var previews: some View {
        HomeVCRepresentable()
            
           // .edgesIgnoringSafeArea(.all)
        
    }
}


#endif


