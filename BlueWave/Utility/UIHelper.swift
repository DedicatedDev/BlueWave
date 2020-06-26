//
//  UIHelper.swift
//  BlueWave
//
//  Created by FreeBird on 4/12/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit

public class UIHelper : UIViewController{
    
    static func FillOutSuperView(childView:UIView, parentView:UIView)
        
       {
           childView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
                      childView.topAnchor.constraint(equalTo: parentView.topAnchor),
                      childView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
                      childView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
                      childView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
                  ])
        
    
          
       }
    
    
    static func FillOutWithConstraintAtLR(childView:UIView, parentView:UIView, constraintValue:CGFloat){
              
              childView.translatesAutoresizingMaskIntoConstraints = false
              NSLayoutConstraint.activate([
                         childView.topAnchor.constraint(equalTo: parentView.topAnchor),
                         childView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: constraintValue),
                         childView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -constraintValue),
                         childView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
                         
                  ])
                     
          }
    
        
    static func FillOutWithMultiplier(childView:UIView, parentView:UIView, multiplier:CGFloat,validAnchor:ValidateAnchor){
        
        childView.translatesAutoresizingMaskIntoConstraints = false
        
        if !validAnchor.top {
            
          NSLayoutConstraint.activate([
                                      
                     childView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
                     childView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
                     childView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
                     childView.heightAnchor.constraint(equalTo: parentView.heightAnchor, multiplier: multiplier),
                                 
                      ])
        }else if !validAnchor.bottom {
            
            NSLayoutConstraint.activate([
                                
                   childView.topAnchor.constraint(equalTo: parentView.topAnchor),
                   childView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
                   childView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
                   childView.heightAnchor.constraint(equalTo: parentView.heightAnchor, multiplier: multiplier),
                                   
                ])
            
        }else if !validAnchor.lead {
            
            NSLayoutConstraint.activate([
                                       
                          childView.topAnchor.constraint(equalTo: parentView.topAnchor),
                          childView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
                          childView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
                          childView.widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: multiplier),
                                          
                       ])
            
            
        }else if !validAnchor.trail{
            NSLayoutConstraint.activate([
                                       
                          childView.topAnchor.constraint(equalTo: parentView.topAnchor),
                          childView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
                          childView.leadingAnchor.constraint(equalTo: parentView.trailingAnchor),
                          childView.widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: multiplier),
                                          
                       ])
            
        }else{
            
            NSLayoutConstraint.activate([
                                                  
                         childView.topAnchor.constraint(equalTo: parentView.topAnchor),
                         childView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
                         childView.leadingAnchor.constraint(equalTo: parentView.trailingAnchor),
                         childView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
                                         
                      ])
        }
        
        
     
    }
    
    
    static func TransparentNavVC(vc:UIViewController){
        
        vc.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        vc.navigationController?.navigationBar.shadowImage = UIImage()
    }
    

      
}
