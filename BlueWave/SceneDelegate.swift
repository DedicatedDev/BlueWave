//
//  SceneDelegate.swift
//  BlueWave
//
//  Created by FreeBird on 4/11/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    
    var window: UIWindow?
      

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
//       let mainNavigationController = MainNC()
//               
//       window = UIWindow(frame: UIScreen.main.bounds)
//       window?.makeKey()
//       window?.rootViewController = mainNavigationController
        
      //  let mainNavigationController = MainNC()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let rootVC  = RootVC()
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        
        window?.windowScene = windowScene
        let mainNC = MainNC(rootViewController: rootVC)
        window?.rootViewController = mainNC
        window?.makeKeyAndVisible()
        
//        mainNC.navigationController?.pushViewController(rootVC, animated: true)
        
        
        //
        
        // Define the menus
//        let leftMenuNavigationController = SideMenuNavigationController(rootViewController: YourViewController)
//        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController
//
//        let rightMenuNavigationController = SideMenuNavigationController(rootViewController: YourViewController)
//        SideMenuManager.default.rightMenuNavigationController = rightMenuNavigationController
//
//        // Setup gestures: the left and/or right menus must be set up (above) for these to work.
//        // Note that these continue to work on the Navigation Controller independent of the view controller it displays!
//        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
//        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
//
//        // (Optional) Prevent status bar area from turning black when menu appears:
//        leftMenuNavigationController.statusBarEndAlpha = 0
//        // Copy all settings to the other menu
//        rightMenuNavigationController.settings = leftMenuNavigationController.settings
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        
        let productIds = Set<String>(arrayLiteral: RegisteredPurchase.oneMonth.rawValue,RegisteredPurchase.threeMonth.rawValue,RegisteredPurchase.sixMonth.rawValue)

        Spinner.start()
        IAPManager.shared.verifySubscriptions(with: productIds) { (msg, productIds, success) in

            Spinner.stop()
            if success{
                
                print(msg)
                GlobalVariables.IAPflag = true

            }else{

                GlobalVariables.IAPflag = false
                print("no")
            }
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        GlobalVariables.IAPflag = false
        print("I'm enter to background")
    }


}

