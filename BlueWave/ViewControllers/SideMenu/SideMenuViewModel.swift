//
//  SideMenuViewModel.swift
//  BlueWave
//
//  Created by FreeBird on 4/13/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import Foundation
import UIKit

class SideMenuViewModel {
    
    var profileImg = UIImage()
    var accountsImage : [UIImage] = []
    var accountsTitle:[String] = []
    var appImage :[UIImage] = []
    var appTitle:[String] = []
    var itemTitle : [String] = []
    
  
    
    init() {
       
       accountsImage = [#imageLiteral(resourceName: "INTRADAYFINAL"),#imageLiteral(resourceName: "swing"),#imageLiteral(resourceName: "outlook")]
       accountsTitle = ["Intraday Signal", "Swing Signal","Market Outlook"]
        
       appImage = [#imageLiteral(resourceName: "QuestionImg"),#imageLiteral(resourceName: "AdmireImg")]
       appTitle = ["Support Center","Profile Info","Log out"]
       
    }
  
    
    func setDataToSideMenuCell(cell:SideMenuItemTCell,section: Int, index:Int){
        
         
        var obj  = SideMenuItem()
        switch section {
        case 1:
            obj.itemImag = accountsImage[index]
            obj.itemTitle = accountsTitle[index]
        case 2:
            if index<2{
                obj.itemImag = appImage[index]
                obj.itemTitle = appTitle[index]
            }else{
                let tintedImage = UIImage(systemName: "power")!.withRenderingMode(.alwaysTemplate)
                obj.itemImag = tintedImage
                obj.itemTitle = appTitle[index]
            }
            
        default:
            
            print("end")
        }
        cell.setDataCell(obj: obj)
    }
    
    func numberOfItemAtSection(index:Int)->Int{
        
        var numberOfItem : Int = 0
        
        switch index {
        case 0:
            numberOfItem = 1
        case 1:
            numberOfItem = 3
        case 2:
            numberOfItem = 3
        default:
            numberOfItem = 1
        }
        
        return numberOfItem
    }
    
    func numberOfSetion()->Int{
        
        return 3
    }
    
}
