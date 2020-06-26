//
//  ProfileTCell.swift
//  BlueWave
//
//  Created by FreeBird on 4/13/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit
import SDWebImage
import LBTATools
import FirebaseAuth


class ProfileTCell: UITableViewCell {

    var container  = UIView(psEnabled: false)
    var profileImgView : SDImageView = {
        let i = SDImageView(psEnabled: false)
        i.image = #imageLiteral(resourceName: "user")
        i.clipsToBounds = true
        i.contentMode = .scaleAspectFill
        return i
    }()
    var userNameLbl :UILabel = {
        let l = UILabel(psEnabled: false)
        l.font = AppFonts.NAMEFONT
        l.text = "Jhone"
        return l
    }()
    var userEmailLbl:UILabel = {
        let l = UILabel(psEnabled: false)
        l.font = AppFonts.MAINFONT
        l.text = "test@gmail.com"
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI(){
        
        self.addSubview(container)
        container.fillSuperview()        
        container.hstack(stack(UIView(),profileImgView,UIView(), distribution:.equalCentering).withWidth(48).withHeight(48),
                         stack(stack(userNameLbl).withHeight(20),
                               stack(userEmailLbl).withHeight(20),
                               alignment: .fill, distribution:.equalCentering),
                    spacing:30,
                    alignment: .fill,
            distribution: .fill).padLeft(30).padTop(17).padBottom(5)
       
        profileImgView.layer.masksToBounds = true
        profileImgView.layer.cornerRadius = 24
    
        UIHelper.FillOutSuperView(childView: container, parentView: self)
        NSLayoutConstraint.activate([
        
            profileImgView.widthAnchor.constraint(equalToConstant: 48),
            profileImgView.heightAnchor.constraint(equalToConstant: 48)
        
        ])
       
 
     //   profileImgView.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataHere(obj:UserInfo){
        
        userNameLbl.text = obj.name
        userEmailLbl.text = Auth.auth().currentUser?.email
        profileImgView.sd_setImage(with: URL(string: obj.imageLink), placeholderImage: #imageLiteral(resourceName: "user"))
        profileImgView.cornerRadius = 24
        
    }

}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct StartVCViewRepresentable: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
        return ProfileTCell()
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct StartVCViewController_Preview: PreviewProvider {
    static var previews: some View {
        StartVCViewRepresentable()
            .previewLayout(.fixed(width: 400, height: 100))
    }
}


#endif
