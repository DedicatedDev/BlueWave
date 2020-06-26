//
//  Extension.swift
//  BBCBooks
//
//  Created by FreeBird on 3/9/20.
//  Copyright © 2020 BBCLearning. All rights reserved.
//

import Foundation
import UIKit

//extension UIColor {
//
//    public convenience init?(hexString: String) {
//           let r, g, b: CGFloat
//
//           let hex = hexString.lowercased()
//           if hex.hasPrefix("#") {
//               let start = hex.index(hex.startIndex, offsetBy: 1)
//               let hexColor = String(hex[start...])
//
//               if hexColor.count == 8 {
//                   let scanner = Scanner(string: hexColor)
//                   var hexNumber: UInt64 = 0
//
//                   if scanner.scanHexInt64(&hexNumber) {
//                       r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
//                       g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
//                       b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
//                     //  a = CGFloat(hexNumber & 0x000000ff) / 255
//
//                    self.init(red: r, green: g, blue: b, alpha: 1.0)
//                       return
//                   }
//               }
//           }
//
//           return nil
//   }
//}

extension UIColor {
    
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (hexString.hasPrefix("#")) {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            hexString = String(hexString[start...])
        }
        let scanner = Scanner(string: hexString)
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}

//extension UIActivityIndicatorView
//{
//
//    func StartAnimation(){
//
//        self.isUserInteractionEnabled = false
//        self.startAnimating()
//    }
//
//    func StopAnimation(){
//
//        self.isUserInteractionEnabled = true
//        self.startAnimating()
//    }
//}


extension UIView {
    
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
}


//naviation Controller Customizing.





extension UIViewController{
    
    func showAlert(_ alert: UIAlertController) {
         guard self.presentedViewController != nil else {
             self.present(alert, animated: true, completion: nil)
             return
         }
     }
    
    func setProgressbar() -> UIActivityIndicatorView{
        
        let progressbar : UIActivityIndicatorView = UIActivityIndicatorView(psEnabled:false)
        
        
        progressbar.center = self.view.center
        if #available(iOS 13.0, *) {
            progressbar.style = UIActivityIndicatorView.Style.large
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 10.0, *) {
            progressbar.color = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 1)
        } else {
            // Fallback on earlier versions
        }
        view.addSubview(progressbar)
        NSLayoutConstraint.activate([
        
            progressbar.topAnchor.constraint(equalTo: view.topAnchor),
            progressbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progressbar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
        
        view.bringSubviewToFront(progressbar)
        
        return progressbar
    }
    
    
  
    
    func SetConstraint(childView:UIView, view:UIView)
    {
        childView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                   childView.topAnchor.constraint(equalTo: view.topAnchor),
                   childView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                   childView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                   childView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
               ])
        
       
    }
     
    func SetConstraintForLeadingAndTrailing(childView:UIView, view:UIView, constraintValue:CGFloat){
        
        childView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                   childView.topAnchor.constraint(equalTo: view.topAnchor),
                   childView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraintValue),
                   childView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraintValue),
                   childView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                   
            ])
               
    }
    

    
    func setupNavigationTitleView(img : UIImage){
        
        let titleImageView = UIImageView(image: img)
        titleImageView.frame = CGRect(x: 0,y: 0,width: 20,height: 20)
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImageView
    }
    
    func setupNavigationTitle(title:String){
        let textAttributes = [NSAttributedString.Key.foregroundColor: AppColors.MAINCOLOR]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = title
    
    }
    
    
    func setupNavigationleftMenuItem(img : UIImage, btntag:Int){
        
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 40, height: 18)
        menuBtn.setImage(img, for: .normal)
        menuBtn.contentMode =  .scaleAspectFill
        menuBtn.tag  = btntag
        menuBtn.addTarget(self, action: #selector(leftButtonAction(sender:)), for: .touchDown)
        
    
        let menuBarItem = UIBarButtonItem (customView : menuBtn)
        let currWidth = menuBarItem.customView? .widthAnchor.constraint (equalToConstant : 40)
        currWidth? .isActive = true
        let currHeight = menuBarItem.customView? .heightAnchor.constraint (equalToConstant : 18)
        currHeight? .isActive = true
        self.navigationItem.leftBarButtonItem = menuBarItem
    }
    
    
    
    func setupNavigationleftItem(img : UIImage, btntag:Int){
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 40, height: 20)
        menuBtn.setImage(img, for: .normal)
        menuBtn.tag  = btntag
        menuBtn.addTarget(self, action: #selector(leftButtonAction(sender:)), for: .touchDown)
        let menuBarItem = UIBarButtonItem (customView : menuBtn)
        let currWidth = menuBarItem.customView? .widthAnchor.constraint (equalToConstant : 20)
        currWidth? .isActive = true
        let currHeight = menuBarItem.customView? .heightAnchor.constraint (equalToConstant : 20)
        currHeight? .isActive = true
        self.navigationItem.leftBarButtonItem = menuBarItem
    }
    
    func setupNavigationRightItem(img:UIImage,title:String,btntag:Int){
    
        
        let rect  = CGRect(x: 0.0, y: 0.0, width:70, height: 30)
        let profileBtn = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 60, height: 30))
        
        profileBtn.setTitle(title, for: .normal)
        profileBtn.setTitleColor(UIColor.red, for: .normal)
        profileBtn.tag = btntag
        
        profileBtn.titleLabel?.font = .systemFont(ofSize: 12)
        profileBtn.addTarget(self, action: #selector(rightButtonAction(sender:)), for: .touchDown)
        
        let nextBtn = UIButton(type: .custom)
         nextBtn.tag  = btntag
         nextBtn.addTarget(self, action: #selector(rightButtonAction(sender:)), for: .touchDown)
        
        nextBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 30)
        nextBtn.setImage(img, for: .normal)
        let nextBtnView = UIView(frame: rect)
        let stackView = UIStackView(arrangedSubviews: [profileBtn, nextBtn])
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        nextBtnView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: nextBtnView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: nextBtnView.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: nextBtnView.trailingAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: nextBtnView.leadingAnchor).isActive = true
        nextBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
       // nextBtnView.backgroundColor = UIColor.red
         
        
        let nextBarItem = UIBarButtonItem(customView: nextBtnView)
        let currWidth = nextBarItem.customView?.widthAnchor.constraint (equalToConstant : 70)
        currWidth? .isActive = true
        let currHeight = nextBarItem.customView? .heightAnchor.constraint (equalToConstant : 30)
        currHeight? .isActive = true
        
        self.navigationItem.rightBarButtonItem = nextBarItem
        
    }
    
    @objc func rightButtonAction(sender: UIButton){
    
        if sender.tag == 100 {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileViewController")
                      self.navigationController?.pushViewController(vc!, animated: true)
            
        }else{
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
          
            self.navigationController?.pushViewController(vc!, animated: false)
        }
            
    }
    
    @objc func leftButtonAction(sender: UIButton){
                 
        switch sender.tag {
            
        case NavBackbtnType.LOGIN:
            self.navigationController?.popToRootViewController(animated: true)
            
        case NavBackbtnType.SIDEMENU:
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NavBehaviorType.MENUTAPED), object: nil)
     
            
        default:
            self.navigationController?.popViewController(animated: true)
        }
       
        
     }
    
    
    class func storyboardInstance(identifier: String) -> UIViewController? {
           let storyboad = UIStoryboard(name: "Main", bundle: nil)
        if #available(iOS 13.0, *) {
            return storyboad.instantiateViewController(identifier: identifier)
        } else {
            // Fallback on earlier versions
            return nil
        }
       }
    
    
    func HideNaviationBoder(){
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    
    func HideKeyboard(){
        
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
    }
    
    @objc func DismissKeyboard(){
        
        view.endEditing(true)
    }
    
}


extension UITextField {
    
    func addHeaderImage(img: UIImage){
        
        let leftView = UIView()
        
        leftView.frame = CGRect(x: 10, y: 5, width: 60, height: 40)
        
        let imageView = UIImageView(image: img)
        
      
        
        imageView.frame = CGRect(x: 10, y: 5, width: 25, height: 25)
        leftView.addSubview(imageView)
        
        
        self.leftView = leftView
        self.leftViewMode = .always
    }

}

extension UIActivityIndicatorView {
    
    
    func beginAnimation(){
        
        self.startAnimating()
      //  self.isUserInteractionEnabled = false
        self.superview?.isUserInteractionEnabled = false
        
    }
    
    func endAnimation(){
        
         self.stopAnimating()
     //   self.isUserInteractionEnabled = true
        self.superview?.isUserInteractionEnabled = true
        
    }
}

extension UIImageView {
    func topAlignmentAndAspectFit(to view: UIView) {
        self.contentMode = .scaleAspectFill
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        
        self.addConstraints(
            [NSLayoutConstraint(item: self,
                                attribute: .height,
                                relatedBy: .equal,
                                toItem: self,
                                attribute: .width,
                                multiplier: self.frame.size.height / self.frame.size.width,
                                constant: 0.0)])
        view.addConstraints(
            [NSLayoutConstraint(item: self,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1.0,
                                constant: 0.0)])
        view.addConstraints(
            [NSLayoutConstraint(item: self,
                                attribute: .width,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .width,
                                multiplier: 1.0,
                                constant: 0.0)])
        view.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView]",
                                           options: .alignAllTop,
                                           metrics: nil,
                                           views: ["imageView": self]))
    }
}


extension UIImage{
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {

        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()

        return newImage
    }
}

extension UIView{

    convenience init(psEnabled : Bool){
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = psEnabled
    }
}

extension UITextField{
    
    func underlined(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
       // self.layoutSubviews()
    }
    
   
     var placeholderColor: UIColor {
        get {
            return attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? .clear
        }
        set {
            guard let attributedPlaceholder = attributedPlaceholder else { return }
            let attributes: [NSAttributedString.Key: UIColor] = [.foregroundColor: newValue]
            self.attributedPlaceholder = NSAttributedString(string: attributedPlaceholder.string, attributes: attributes)
        }
    }
}

//extension UITabBar{
//    
//    override open func sizeThatFits(_ size: CGSize) -> CGSize {
//        super.sizeThatFits(size)
//        var sizeThatFits = super.sizeThatFits(size)
//        sizeThatFits.height = 113
//        return sizeThatFits
//    }
//    
//}


extension Date{
    
    func asString()->String{
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM-dd-yyyy HH:mm"
        
        return dateFormater.string(from: self)
    }
}


 extension UIDevice {

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod touch (5th generation)"
            case "iPod7,1":                                 return "iPod touch (6th generation)"
            case "iPod9,1":                                 return "iPod touch (7th generation)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone12,1":                              return "iPhone 11"
            case "iPhone12,3":                              return "iPhone 11 Pro"
            case "iPhone12,5":                              return "iPhone 11 Pro Max"
            case "iPhone12,8":                              return "iPhone SE (2nd generation)"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12":                    return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                      return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                    return "iPad (7th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad11,4", "iPad11,5":                    return "iPad Air (3rd generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad mini (5th generation)"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
            case "iPad8,9", "iPad8,10":                     return "iPad Pro (11-inch) (2nd generation)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "iPad8,11", "iPad8,12":                    return "iPad Pro (12.9-inch) (4th generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()

}

