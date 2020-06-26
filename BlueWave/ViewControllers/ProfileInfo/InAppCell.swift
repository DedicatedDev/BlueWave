//
//  ProfileInfoCell.swift
//  BlueWave
//
//  Created by FreeBird on 4/18/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit


class InAppCell: UITableViewCell {

    
    var callback:(()->Void)?
    let container = UIView(psEnabled: false)
       let monthLbl : UILabel = {
           
           let l = UILabel(psEnabled: false)
           l.font = UIFont(name: AppFontNames.HelveticaBold, size: 190)
           l.text = "6"
           l.textAlignment = .center
           l.textColor = UIColor(hexString: "#2A4D77")
           
           return l
       }()
       
       let monthCaption : UILabel = {
           
           let l = UILabel(psEnabled: false)
           l.font = UIFont(name: AppFontNames.HelveticaBold, size: 22)
           l.text = "MONTH"
           l.textAlignment = .center
           l.textColor = UIColor(hexString: "#2A4D77")
           
           return l
           
       }()
       

       let descriptLbl : UILabel = {
             
        let l = UILabel(psEnabled: false)
        l.font = UIFont(name: AppFontNames.InterRegular, size: 16)
        l.numberOfLines = 0
        l.text = "Full focus for 6 month subscription for full signal of forex. More savers with 6 month subscription.Brilliant choice!"
             return l
         }()
       
       let priceLbl : UILabel = {
            
            let l = UILabel(psEnabled: false)
            l.font = UIFont(name: AppFontNames.HelveticaBold, size: 27)
            l.text = "RM269"
            l.textAlignment = .right
            l.textColor = UIColor(hexString: "#2A4D77")
            
            return l
            
        }()
        
       
       
      
    let getNowBtn : UIButton = {
        
        let b = UIButton(psEnabled: false)
        b.backgroundColor  = UIColor(hexString: "#13BDE5")
        b.setTitle("GET NOW", for: .normal)
        b.titleLabel?.font = UIFont(name: AppFontNames.InterBold, size: 20)
        b.layer.cornerRadius = 5
       
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
       // container.fillSuperview()
                   setupView()
        container.layer.cornerRadius = 20
      
        
        NSLayoutConstraint.activate([
        
            container.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        
        ])
        
    }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    
    func setupView(){
        
        container.backgroundColor = AppColors.GREYBGCOLOR

        container.hstack(stack(monthLbl,monthCaption,distribution:.fillProportionally),
                         stack(descriptLbl,priceLbl,hstack(UIView(),stack(getNowBtn).withWidth(147),spacing:10,distribution:.fillProportionally)).withHeight(49)).padBottom(20).padTop(20).padRight(10)
        
        
    
      getNowBtn.addTarget(self, action: #selector(getNow), for: .touchDown)
    }
    

    @objc func getNow(){

       callback?()
        
    }
    
    func setDataCell(obj:InAppModel){
        
        monthLbl.text = obj.month
        descriptLbl.text = obj.descript
        priceLbl.text = "\(obj.price)"
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct InAppCellRepresentable: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
        return InAppCell()
    }

    func updateUIView(_ view: UIView, context: Context) {

    }
}

@available(iOS 13.0, *)
struct InAppCell_Preview: PreviewProvider {
    static var previews: some View {
        InAppCellRepresentable()
            .previewLayout(.fixed(width: 320, height: 300))
    }
}


#endif
