//
//  ProfileInfoCell.swift
//  BlueWave
//
//  Created by FreeBird on 4/18/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit
import FirebaseAuth

//protocol UpdateCellDelegate {
//    func trytoUpdateProfile()
//}

class UpdateInfoCell: UITableViewCell {

  
    var callback:(()->Void)?
    
    let container = UIView(psEnabled: false)
    
       let nameCaptionLbl : UILabel = {
           
           let l = UILabel(psEnabled: false)
           l.font = UIFont(name: AppFontNames.InterBold, size: 22)
           l.text = "Name"
           
           return l
       }()
       
       let nameLbl : UITextField = {
           
           let l = UITextField(psEnabled: false)
           l.font = UIFont(name: AppFontNames.InterRegular, size: 22)
           l.text = "Johne Doe"
           return l
           
       }()
       

       let phoneNoCaptionLbl : UILabel = {
             
             let l = UILabel(psEnabled: false)
             l.font = UIFont(name: AppFontNames.InterBold, size: 22)
              l.text = "Phone No."
             return l
         }()
       
       let phoneNumberLbl : UITextField = {
            
            let l = UITextField(psEnabled: false)
            l.font = UIFont(name: AppFontNames.InterRegular, size: 22)
            l.text = "60171231234"
            
            return l
            
        }()
        
       
       
       let emailCaptionLbl : UILabel = {
             
             let l = UILabel(psEnabled: false)
             l.font = UIFont(name: AppFontNames.InterBold, size: 22)
             l.text = "Email"
             return l
         }()
       
       let emailLbl : UITextField = {
            
            let l = UITextField(psEnabled: false)
            l.font = UIFont(name: AppFontNames.InterRegular, size: 22)
            l.text = "johndoe@gmail.com"
            
            return l
            
        }()
    
    let updateBtn : UIButton = {
        
        let b = UIButton(psEnabled: false)
        b.backgroundColor  = UIColor(hexString: "#13BDE5")
        b.setTitle("Update", for: .normal)
        b.titleLabel?.font = UIFont(name: AppFontNames.InterBold, size: 20)
        b.layer.cornerRadius = 5
      //  b.addTarget(self, action: #selector(updateProfile), for: .touchDown)
        
        return b
        
    }()
    
    let separaterView1: UIView = {
         let v = UIView()
         v.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
         v.translatesAutoresizingMaskIntoConstraints = false
         return v
     }()
    
    let separaterView2: UIView = {
         let v = UIView()
         v.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
         v.translatesAutoresizingMaskIntoConstraints = false
         return v
     }()
    let separaterView3: UIView = {
         let v = UIView()
         v.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
         v.translatesAutoresizingMaskIntoConstraints = false
         return v
     }()
    
    
    
    let subScriptionLbl : UILabel = {
          
          let l = UILabel(psEnabled: false)
          l.font = UIFont(name: AppFontNames.InterBold, size: 22)
          l.text = "Subscription Plan"
          l.textAlignment = .center
          return l
      }()
    
    let subscriptionValueLbl : UILabel = {
           
           let l = UILabel(psEnabled: false)
           l.font = UIFont(name: AppFontNames.InterRegular, size: 22)
           l.text = "6"
           l.textAlignment = .center
           
           return l
           
       }()
       
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                   super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        self.addSubview(container)
        separaterView1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separaterView2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separaterView3.heightAnchor.constraint(equalToConstant: 1).isActive = true
        container.fillSuperview()
                   setupView()
        }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    
    func setupView(){
    
        
       container.stack(stack(nameCaptionLbl,stack(nameLbl, separaterView1,spacing:3),spacing:5),
                       stack(phoneNoCaptionLbl,stack(phoneNumberLbl, separaterView2, spacing:3),spacing:5),
                       stack(emailCaptionLbl,stack(emailLbl,separaterView3,spacing:3),spacing:5),
                       UIView(),
                       hstack(UIView(),updateBtn.withWidth(147),UIView(),spacing:20, alignment: .fill,distribution: .equalCentering).withHeight(49),
        spacing: 20, alignment: .fill, distribution: .fill).padTop(20).padBottom(210).padLeft(20).padRight(20)

        updateBtn.addTarget(self, action: #selector(updateProfile), for:
            .touchUpInside)
        
    }
    
    
    func setDataHere(obj:UserInfo){
        
        nameLbl.text = obj.name
        emailLbl.text = Auth.auth().currentUser?.email
        phoneNumberLbl.text = obj.phonenumber
        subscriptionValueLbl.text = "6"
        
    }
    
    @objc func updateProfile(){
        
       callback?()
     
    }

}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct UpdateInfoCellRepresentable: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
        return UpdateInfoCell()
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct UdateInfoCell_Preview: PreviewProvider {
    static var previews: some View {
        UpdateInfoCellRepresentable()
            .previewLayout(.fixed(width: 414, height: 700))
    }
}


#endif
