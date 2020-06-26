//
//  IntradaySignalVC.swift
//  BlueWave
//
//  Created by FreeBird on 4/13/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit

class IntradaySignalVC: UIViewController {
    
    let tabBar = PYSTabBarController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       self.view.addSubview(tabBar.view)

    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct DebugISViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        
        let discoverNC = UINavigationController(rootViewController: IntradaySignalVC())
        return discoverNC.view
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct IntradaySignalVC_Preview: PreviewProvider {
    static var previews: some View {
       
        DebugISViewRepresentable()
            .edgesIgnoringSafeArea(.all)
        
    }
}


#endif
