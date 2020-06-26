//
//  RunningVC.swift
//  BlueWave
//
//  Created by FreeBird on 4/13/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit
import SideMenu

class SignalVC: UIViewController {

  var profileinfoVM = ProfileInfoVM()
  let signalBoardView = SignalBoard()

  var viewTitle:String = "Intraday Signal"
  var vm = SignalViewModel()
  let menu = SideMenuNavigationController(rootViewController: SideMenuVC())
  let menuManager = SideMenuManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if GlobalVariables.selectedSignalSrc == DataSrcType.INTRADAYSIGNAL{
            viewTitle = "Intraday Signal"
        }else{
            viewTitle = "Swing Signal"
        }
        UIHelper.TransparentNavVC(vc: self)
        setupUI()
        setupNavbar()
        setupSideMenu()
        signalBoardView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(treatNotification), name: NSNotification.Name(rawValue: "emptyImage"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateSignal), name: NSNotification.Name(rawValue: "NewSignal"), object: nil)
        
    }
    
    
    @objc func updateSignal(){
        
        getDataSource()
        
    }

    @objc func treatNotification(){
        
        Utility.showMsg(vc: self, title: "BlueWave", msgTxt: "Sorry but there is no image here!")
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
    
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    func getDataSource(){
        
        let progressbar = self.setProgressbar()
        progressbar.color = .black
        progressbar.beginAnimation()
        
        vm.getSignals(srcType: GlobalVariables.selectedSignalSrc, completion: { (success, msg) in
               
            progressbar.endAnimation()
                if success{
                    print("goood")
                    
                    if GlobalVariables.selectedStatus == StatusType.Running
                    {
                        self.signalBoardView.updateData(obj: self.vm.runningSignals)
                       
                        
                    }else if GlobalVariables.selectedStatus == StatusType.Closed{
                        
                        self.signalBoardView.updateData(obj: self.vm.closedSignals)
                        
                    }
                    
                }else{
                    
                    Utility.showMsgForResult(vc: self, title:AppsMainInfo.AppName, msgTxt: "Some thing went wrong")
                    
                }
            })
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
      
        self.tabBarController?.tabBar.isHidden = false
        profileinfoVM.getUserInfo { (success, msg) in
            
            if success{
                GlobalVariables.currentUserInfo = self.profileinfoVM.fullUserInfo
                
            }else{
                print("error")
            }
        }
        
        
         getDataSource()
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
        
        let container = SemiRadiusView(psEnabled: false)
        container.backgroundColor = AppColors.GREYBGCOLOR
        container.cornerRadius = 60
        view.addSubview(container)
        container.stack(signalBoardView).padTop(20).padBottom(90)
        
        
      
      NSLayoutConstraint.activate([

          container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
          container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          container.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.89),

      ])
    }

}

extension SignalVC:SignalBoardDelegate{
   
    func CallZoomView(img: UIImage) {
    
        let vc = ZoomImageVC()
        vc.originalImg = img
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
}





#if canImport(SwiftUI) && DEBUG
import SwiftUI


struct DiscoverVCViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        
        let discoverNC = UINavigationController(rootViewController: SignalVC())
        return discoverNC.view
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct DiscoverVCViewController_Preview: PreviewProvider {
    static var previews: some View {
        DiscoverVCViewRepresentable()
            
            .edgesIgnoringSafeArea(.all)
        
    }
}


#endif
