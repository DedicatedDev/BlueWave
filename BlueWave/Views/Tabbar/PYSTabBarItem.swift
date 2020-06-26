//
//  PYSTabBarItem.swift
//  BlueWave
//
//  Created by FreeBird on 4/13/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit

class PYSTabBarItem: UITabBarItem {

    override init() {
        super.init()
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        
        UIBarItem.self.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        UIBarItem.self.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)

        UIBarItem.self.appearance().setTitleTextAttributes([NSAttributedString.Key.font: AppFonts.TABBARITEMFONT], for: .normal)
        
        print("I'm hree")
        print(safeAreaHeight)
        self.imageInsets = UIEdgeInsets(top: -(113-safeAreaHeight-15), left: 0, bottom: 0, right: 0)
        self.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -(113-safeAreaHeight)/2 + 15)

    }
}
