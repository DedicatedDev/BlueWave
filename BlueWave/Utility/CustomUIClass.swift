//
//  CustomUIClass.swift
//  MealzCard
//
//  Created by FreeBird on 3/10/20.
//  Copyright © 2020 MealzCardClub. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit
import SkyFloatingLabelTextField

class CornerRadiusButton: UIButton {

    func setup() {

       self.layer.cornerRadius = 10
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

}

class RadiusUIView: UIView {
    
    func setup() {

       self.layer.cornerRadius = 5
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

class SemiRadiusView : UIView{
    
    var cornerRadius : CGFloat = 0
    override init(frame: CGRect) {
         super.init(frame: frame)
         
     }
     required public init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)

     }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          roundCorners(corners: [.topLeft, .topRight], radius: cornerRadius)
      }
}



 open class UnderLineTextField : UITextField {
    
    
   var tintText = ""
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }


    func setup() {

        self.font = AppFonts.MAINFONT
        self.textColor = UIColor.white
        self.attributedPlaceholder = NSAttributedString(string: tintText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        let  bottomLine = CALayer()
        self.borderStyle = .line
        bottomLine.frame = CGRect(x:0, y:self.frame.height-2,width: self.frame.width,height: 0.5)
        bottomLine.backgroundColor  = UIColor.white.cgColor
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
        

    }

    func addHeaderTitle(title:String, font: UIFont) {

        let leftView = UILabel()//(frame: CGRect(x: 0,y: 0,width: 100,height: 100))


        leftView.text = title + "  "
        leftView.textColor = UIColor.white


        self.leftView = leftView
        self.leftViewMode = .always
        self.leftView?.isUserInteractionEnabled = true

    }
    
//    open override func layoutSubviews() {
//        super.layoutSubviews()
//        setup()
//    }


}


class CustomTextView: UITextView {

    func setup() {

       self.layer.cornerRadius = 5
        
    }


    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
  
}





class EditTextField : UITextField {
    
    func setup() {

        self.layer.cornerRadius = 5
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
}


class CheckBox: UIButton {

    //image
     let checkedImage = #imageLiteral(resourceName: "checked")
     let uncheckedImage = #imageLiteral(resourceName: "unchecked")
     
    //bool property
     
     var isChecked:Bool = false{
         didSet{
             if isChecked == true{
                 self.setImage(checkedImage, for: .normal)
                 self.setImage(checkedImage, for: .normal)
             }else{
                 self.setImage(uncheckedImage, for: .normal)
             }
         }
     }

     override func awakeFromNib() {
         
         self.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
         self.isChecked = false
     }

     @objc func buttonClicked(_ sender:UIButton) {

         if(sender == self){
             if isChecked == true{
                 isChecked = false
             }else{
                 isChecked = true
             }
         }
     }

}

class UnderlinedLabel: UILabel {

override var text: String? {
    didSet {
        guard let text = text else { return }
        let textRange = NSMakeRange(0, text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        // Add other attributes if needed
        self.attributedText = attributedText
        }
    }
}


class SDImageView: UIImageView {
    
    @IBInspectable var cornerRadius : CGFloat = 0.0{
        didSet{
            self.applyCornerRadius()
        }
    }
    
    @IBInspectable var borderColor : UIColor = UIColor.clear{
        didSet{
            self.applyCornerRadius()
        }
    }
    
    @IBInspectable var borderWidth : Double = 0{
        didSet{
            self.applyCornerRadius()
        }
    }
    
    @IBInspectable var circular : Bool = false{
        didSet{
            self.applyCornerRadius()
        }
    }
    
    func applyCornerRadius()
    {
        if(self.circular) {
            self.layer.cornerRadius = self.bounds.size.height/2
            self.layer.masksToBounds = true
            self.layer.borderColor = self.borderColor.cgColor
            self.layer.borderWidth = CGFloat(self.borderWidth)
        }else {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
            self.layer.borderColor = self.borderColor.cgColor
            self.layer.borderWidth = CGFloat(self.borderWidth)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyCornerRadius()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyCornerRadius()
    }
    
}

class BorderView : UIView{
    
    override func awakeFromNib() {
           super.awakeFromNib()
            ApplyShadow()
       }
       
       override func layoutSubviews() {
           super.layoutSubviews()
           ApplyShadow()
       }
    
    
    func ApplyShadow()
    {
       self.layer.cornerRadius = 5
       self.layer.shadowColor = UIColor.black.cgColor
       self.layer.shadowOpacity = 0.2
       self.layer.shadowOffset = .zero
       self.layer.shadowRadius = 10
       self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
       self.layer.shouldRasterize = true
    }
    
}


public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
}

//class SDImageView: UIImageView {
//
//@IBInspectable var cornerRadius : CGFloat = 0.0{
//    didSet{
//        self.applyCornerRadius()
//    }
//}
//
//@IBInspectable var borderColor : UIColor = UIColor.clear{
//    didSet{
//        self.applyCornerRadius()
//    }
//}
//
//@IBInspectable var borderWidth : Double = 0{
//    didSet{
//        self.applyCornerRadius()
//    }
//}
//
//@IBInspectable var circular : Bool = false{
//    didSet{
//        self.applyCornerRadius()
//    }
//}






