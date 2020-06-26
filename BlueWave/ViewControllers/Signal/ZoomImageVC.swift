//
//  ZoomImageVC.swift
//  BlueWave
//
//  Created by FreeBird on 5/10/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit

class ZoomImageVC: UIViewController {

    var originalImg:UIImage?
    var zoomImgView:UIImageView = {
        
        let iv = UIImageView(psEnabled: false)
        iv.backgroundColor = .black
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 15
        
        return iv
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        setupUI()
    }
    
    func setupUI(){
        
        zoomImgView.image = originalImg
        zoomImgView.contentMode = .scaleAspectFill
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(zoomImgView)
        
        let ratio = (originalImg?.size.width)!/(originalImg?.size.height)!
        if view.frame.width*0.95 / ratio > view.frame.height * 0.8{
            
            let width = view.frame.height * ratio * 0.8
            let heigt = view.frame.height * 0.8
            zoomImgView.widthAnchor.constraint(equalToConstant: width).isActive = true
            zoomImgView.heightAnchor.constraint(equalToConstant: heigt).isActive = true
            
        }else{
            
            let width = view.frame.width * 0.95
            let heigt = view.frame.width / ratio
            zoomImgView.widthAnchor.constraint(equalToConstant: width).isActive = true
            zoomImgView.heightAnchor.constraint(equalToConstant: heigt).isActive = true
            
        }
        
        zoomImgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        zoomImgView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        zoomImgView.image = originalImg

    }
    
}
