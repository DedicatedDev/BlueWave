//
//  ProfileHeader.swift
//  BlueWave
//
//  Created by FreeBird on 4/18/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileHeader: UITableViewHeaderFooterView{

    var callback : (()->Void)?
    
    let  userImgView : SDImageView = {
           
           let iv =  SDImageView(psEnabled: false)
           iv.clipsToBounds = true
           iv.layer.cornerRadius = 80
           iv.image = #imageLiteral(resourceName: "user")
        return iv
           
       }()
    
    let imagBtn = UIButton(psEnabled: false)
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
         setupView()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView(){

        let imageContainer = UIView()
        stack(imageContainer).padBottom(1).padRight(1).padLeft(1).padTop(1)

        imageContainer.addSubview(userImgView)
        imageContainer.addSubview(imagBtn)

        imagBtn.addTarget(self, action: #selector(uploadImage), for: .touchDown)
        imageContainer.bringSubviewToFront(imagBtn)

        NSLayoutConstraint.activate([

            userImgView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            userImgView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10),
            userImgView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            userImgView.widthAnchor.constraint(equalTo: userImgView.heightAnchor, multiplier: 1),

            imagBtn.topAnchor.constraint(equalTo: userImgView.topAnchor),
            imagBtn.leadingAnchor.constraint(equalTo: userImgView.leadingAnchor),
            imagBtn.trailingAnchor.constraint(equalTo: userImgView.trailingAnchor),
            imagBtn.bottomAnchor.constraint(equalTo: userImgView.bottomAnchor)

        ])
        
        imagBtn.addTarget(self, action: #selector(uploadImage), for: .touchDown)

        userImgView.layer.masksToBounds = true
        userImgView.cornerRadius = 80
       
    }
    
    @objc func uploadImage(){
        callback?()
    }
    
    func setUserImage(imgLink:String){
        
        let originalImg = userImgView.image
        userImgView.sd_setImage(with: URL(string: imgLink ), placeholderImage: originalImg)
    }
    
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ProfileHeaderRepresentable: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
        return ProfileHeader()
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct ProfileHeader_Preview: PreviewProvider {
    static var previews: some View {
        ProfileHeaderRepresentable()
            .previewLayout(.fixed(width: 414, height: 220))
    }
}


#endif
