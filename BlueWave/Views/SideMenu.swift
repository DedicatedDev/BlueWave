//
//  SideMenu.swift
//  BlueWave
//
//  Created by FreeBird on 4/13/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit

class SideMenu: UIView {

    var width : CGFloat = 0
    var container : UIView = UIView()
    var widthSize : NSLayoutConstraint?
    
    var isOpened : Bool = true{
        didSet{
            if isOpened{
                collpase()
            }else{
                expand()
            }
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
   
      
     //   SetupConstraint()

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func SetupConstraint(){

        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .green
        
        widthSize = self.widthAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
        
            self.topAnchor.constraint(equalTo: container.topAnchor),
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor),
  
            
        ])
    
        
    }
    
    func collpase(){
        
        widthSize?.isActive = true
        UIView.animate(withDuration: Double(0.5), animations: {
            self.widthSize?.constant = 0
            self.layoutIfNeeded()
        })
    }
    
    func expand(){
        
  widthSize?.isActive = true
        UIView.animate(withDuration: Double(0.5), animations: {
            
            
            self.widthSize?.constant = self.width
            self.layoutIfNeeded()
        
        })
        
    }
    
   
    
    
    
}
