//
//  ProfileInfoCell.swift
//  BlueWave
//
//  Created by FreeBird on 4/18/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol ProfileInfoCellDelegate {
    
    func checkingUser()
    func gotoInAppVC()
}

class ProfileInfoCell: UITableViewCell {

    var delegate : ProfileInfoCellDelegate?
    
    let container = UIView(psEnabled: false)
    
       let nameCaptionLbl : UILabel = {
           
           let l = UILabel(psEnabled: false)
           l.font = UIFont(name: AppFontNames.InterBold, size: 22)
           l.text = "Name"
           
           return l
       }()
       
       let nameLbl : UILabel = {
           
           let l = UILabel(psEnabled: false)
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
       
       let phoneNumberLbl : UILabel = {
            
            let l = UILabel(psEnabled: false)
            l.font = UIFont(name: AppFontNames.InterRegular, size: 22)
            l.text = ""
            
            return l
            
        }()
        
       
       
       let emailCaptionLbl : UILabel = {
             
             let l = UILabel(psEnabled: false)
             l.font = UIFont(name: AppFontNames.InterBold, size: 22)
           l.text = "Email"
             return l
         }()
       
       let emailLbl : UILabel = {
            
            let l = UILabel(psEnabled: false)
            l.font = UIFont(name: AppFontNames.InterRegular, size: 22)
            l.text = ""
            
            return l
            
        }()
    
    let updateBtn : UIButton = {
        
        let b = UIButton(psEnabled: false)
        b.backgroundColor  = UIColor(hexString: "#13BDE5")
        b.setTitle("Update", for: .normal)
        b.titleLabel?.font = UIFont(name: AppFontNames.InterBold, size: 20)
        b.layer.cornerRadius = 5
       
        
        
        return b
        
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
           l.text = "None"
            l.numberOfLines = 0
           l.textAlignment = .center
           
           return l
           
       }()
       
    


    let viewBtn : UIButton = {
        
        let b = UIButton(psEnabled: false)
        b.backgroundColor  = UIColor(hexString: "#13BDE5")
        b.setTitle("View", for: .normal)
        b.titleLabel?.font = UIFont(name: AppFontNames.InterBold, size: 20)
        b.layer.cornerRadius = 10
       
        
        return b
        
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
        container.fillSuperview()
                   setupView()
               }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    
    func setupView(){
        
     //   let pInfoContainer = UIView(psEnabled: false)

         updateBtn.addTarget(self, action: #selector(showUpdateVC), for: .touchDown)
         viewBtn.addTarget(self, action: #selector(showInAppVC), for: .touchDown)
        let upperContainer = UIView(psEnabled: false)
        let subContainer = UIView(psEnabled: false)
        
        upperContainer.stack(container.hstack(nameCaptionLbl,
                                                   phoneNoCaptionLbl,spacing:0,distribution: .fillEqually),
                   hstack(nameLbl,phoneNumberLbl,spacing:0,distribution: .fillEqually),
                            UIView(),
                            emailCaptionLbl,
                            emailLbl,
                           hstack(UIView(),updateBtn.withWidth(147),UIView(), spacing:20, alignment: .fill,distribution: .equalCentering).withHeight(49),
            spacing: 10, alignment: .fill, distribution: .fill).padTop(20).padBottom(10).padLeft(20).padRight(20)
        
        subContainer.stack(UIView(),stack(subScriptionLbl,subscriptionValueLbl,hstack(UIView(),stack(viewBtn).withWidth(147),UIView(),distribution: .equalCentering).withHeight(49), spacing:10),UIView(), spacing: 10, alignment: .fill, distribution: .equalSpacing)
        
        
        container.stack(upperContainer,subContainer,distribution: .fillEqually).padBottom(200)
    }
    
   @objc func showUpdateVC(){
        
       delegate?.checkingUser()
    
    }

    @objc func showInAppVC(){
        
        delegate?.gotoInAppVC()
    }
    
    
    func setDataHere(obj:UserInfo){
        
        nameLbl.text = obj.name
        phoneNumberLbl.text = obj.phonenumber
        emailLbl.text = Auth.auth().currentUser?.email
        
        
        if GlobalVariables.IAPflag{
            
           if obj.memberShipInfoIOS?.autoRenewStatus == "1"{
                       
           let displayText = "\(obj.memberShipInfoIOS?.mainInfo?.period ?? "")month\n\(obj.memberShipInfoIOS?.mainInfo?.price ?? "")\(obj.memberShipInfoIOS?.mainInfo?.currencyType ?? "")"
               subscriptionValueLbl.text = displayText
               
           }else{
               subscriptionValueLbl.text = "Canceled\n"
           }
        }else{
            
            subscriptionValueLbl.text = "None\n"
        }
       
    
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ProfileInfoCellRepresentable: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
        return ProfileInfoCell()
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct ProfileInfoCell_Preview: PreviewProvider {
    static var previews: some View {
        ProfileInfoCellRepresentable()
            .previewLayout(.fixed(width: 414, height: 700))
    }
}


#endif
