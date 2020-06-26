//
//  SupportVC.swift
//  BlueWave
//
//  Created by FreeBird on 5/11/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit
import SideMenu
import LBTATools

class SupportVC: UIViewController {

  var viewTitle:String = "Support Center"
  var vm = SignalViewModel()
  let menu = SideMenuNavigationController(rootViewController: SideMenuVC())
  let menuManager = SideMenuManager()
    let contentLbl:UILabel = {
        
        let l = UILabel(psEnabled: false)
        l.numberOfLines = 0
        l.font = UIFont(name: AppFontNames.InterRegular, size: 20)
        
        l.text = "Hi,\n\n\nNeed help? Please send us an email to successresult@gmail.com. We will respond to your email\nas soon as possible within 48hours working days. Enjoy the signal and enjoy the profit.\n\n\n\n\n Thank you for your patience,Customer Hero Support"
        
        return l
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        UIHelper.TransparentNavVC(vc: self)
        setupUI()
        setupNavbar()
        setupSideMenu()
      
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
      
        self.tabBarController?.tabBar.isHidden = false
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

        title.text = viewTitle
        navigationItem.titleView = title

        }
      
    
    @objc func onTapMenu() {
        present(menu, animated: true, completion: nil)
    }
    @objc func onClickLogo() {
        present(menu, animated: true, completion: nil)
    }

    
    private func setupSideMenu() {
        
        menuManager.leftMenuNavigationController = menu
        menuManager.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
            menuManager.addScreenEdgePanGesturesToPresent(toView: view, forMenu: .left)
            menu.statusBarEndAlpha = 0
            menu.menuWidth = view.frame.size.width
            menu.animationOptions = .allowUserInteraction
            menu.navigationBar.isHidden = true
            menu.presentationStyle = .menuSlideIn
    }

    
    
    func setupUI(){
        

        self.view.stack(contentLbl).padRight(30).padLeft(30).padBottom(30).padTop(10)
        
        
      
//      NSLayoutConstraint.activate([
//
//          container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//          container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//          container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//          container.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.89),
//
//      ])
    }

}


#if canImport(SwiftUI) && DEBUG
import SwiftUI


struct SupportVCViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        
        let discoverNC = UINavigationController(rootViewController: SupportVC())
        return discoverNC.view
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct SupportVCViewController_Preview: PreviewProvider {
    static var previews: some View {
        SupportVCViewRepresentable()
            
            .edgesIgnoringSafeArea(.all)
        
    }
}


#endif
