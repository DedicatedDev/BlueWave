//
//  PYSTabBarController.swift
//  BlueWave
//
//  Created by FreeBird on 4/13/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit
import SideMenu

class PYSTabBarController: UITabBarController {

       let menu = SideMenuNavigationController(rootViewController: SideMenuVC())
  //  var tabBarItem : UITabBarItem = UITabBarItem()
    var itemVC : [UIViewController] = []
    var tabItemTitle : [String] = [TabItemTitle.RUNNING,TabItemTitle.CLOSED,TabItemTitle.SUMMARY]
    
    let firstVC = SignalVC()
    let secondVC = SignalVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
       
        
    }
    

    func setupTabBar(){
        

     
        //let thirdVC = SignalVC()

        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: AppFonts.TABBARITEMFONT], for: .normal)
        
    
        
        let item1 = PYSTabBarItem(title: TabItemTitle.RUNNING, image: UIImage().withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage:#imageLiteral(resourceName: "tapIcon"))
        
            
        let item2 = PYSTabBarItem(title: TabItemTitle.CLOSED, image: UIImage().withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage:#imageLiteral(resourceName: "tapIcon"))

    
        firstVC.tabBarItem = item1
        secondVC.tabBarItem = item2
       // thirdVC.tabBarItem = item3
        
        let vc1 = UINavigationController(rootViewController: firstVC)
        let vc2 = UINavigationController(rootViewController: secondVC)
        viewControllers = [vc1,vc2]
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
          tabBar.frame.size.height = 113
          tabBar.frame.origin.y = view.frame.height - 113
          print(tabBar.frame.size.height)
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item.title == "CLOSED"{
            GlobalVariables.selectedStatus = StatusType.Closed
        }else{
            GlobalVariables.selectedStatus = StatusType.Running
        }
        
    }

}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct PYSTCViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        
        let discoverNC = PYSTabBarController ()
        return discoverNC.view
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct PYSTCViewController_Preview: PreviewProvider {
    static var previews: some View {
        PYSTCViewRepresentable()
            
            .edgesIgnoringSafeArea(.all)
        
    }
}


#endif




