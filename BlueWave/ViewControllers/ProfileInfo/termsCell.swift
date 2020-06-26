//
//  termsCell.swift
//  BlueWave
//
//  Created by FreeBird on 4/30/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import Foundation
import UIKit

protocol TermsCellDelegate {
    
    func tryRestoreIAP()
}

class termsCell: UITableViewCell,UITextViewDelegate {
    
    var delegatge:TermsCellDelegate?
    let container : UIView = {
        
        let v = UIView(psEnabled: false)
        v.backgroundColor = AppColors.GREYBGCOLOR
        v.layer.cornerRadius = 20
        
        return v
    }()
    let termsLbl : UITextView = {
        
        let l = UITextView(psEnabled: false)
        l.textAlignment = .justified
       
    
    
        let description = NSMutableAttributedString(string: "A purchase amount and period purchase will be applied to your iTunes account. Subscriptions will automatically continue unless canceled within 24-hours before the end of the current period. You can cancel anytime with your iTunes account settings. Any unused portion of a free trial will be forfeited if you purchase a subscription. For more information, ask to support.")
        
        let supportLink = NSMutableAttributedString(string: "Support")
        supportLink.addAttribute(.link, value: Links.supportLink, range:NSRange(location: 0, length: supportLink.length))
        
        let privacyLink = NSMutableAttributedString(string: "Privacy Policy")
        privacyLink.addAttribute(.link, value: Links.termsLink, range: NSRange(location: 0, length: privacyLink.length))
        let and = NSMutableAttributedString(string: " and ")
        
        description.append(supportLink)
        description.append(and)
        description.append(privacyLink)
        l.attributedText = description
        l.textAlignment = .justified
        l.backgroundColor = .clear
         l.font = UIFont(name: AppFontNames.InterRegular, size: 16)
        
        return l
        
        
    }()
    
    let restoreBtn:UIButton = {
        
        let b = UIButton(psEnabled: false)
        b.setTitle("Restore", for: .normal)
        b.withHeight(44)
        b.withWidth(130)
        b.layer.cornerRadius = 10
        b.backgroundColor = AppColors.BTNCOLOR
        b.addTarget(self, action: #selector(restoreIAPInfo), for: .touchDown)
        return b
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier:   reuseIdentifier)
        
        setupCell()
        termsLbl.delegate = self
        
    }
    
    func setupCell(){
        
        self.stack(container).padTop(10).padLeft(20).padRight(20).padBottom(10)
        
        container.stack(termsLbl,restoreBtn).padTop(10).padLeft(10).padRight(10).padBottom(10)
        restoreBtn.addTarget(self, action: #selector(restoreIAPInfo), for: .touchDown)
   
    }    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
          UIApplication.shared.open(URL)
          return false
      }
    
    
    @objc func restoreIAPInfo(){
        
        delegatge?.tryRestoreIAP()
        
    }
    
}
