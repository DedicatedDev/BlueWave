//
//  UIHelper.swift
//  BlueWave
//
//  Created by FreeBird on 4/12/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//
import UIKit
var deviceSize = DeviceSize()
var currentVC = UIViewController()
struct AppColors{
    
    static let MAINCOLOR : UIColor = UIColor(hexString: "#2A4D77")
    static let GREYBGCOLOR : UIColor = UIColor(hexString: "#EDF0F4")
    static let BTNCOLOR :  UIColor = UIColor(hexString: "#13BDE5")
    static let BTNGREYCOLOR: UIColor = UIColor(hexString: "#D3DBDE")
}

struct AppFonts{
    static let MAINFONT : UIFont = UIFont(name: "Inter-Regular", size: 16)!
    static let TitleFONT : UIFont = UIFont(name: "Inter-Bold", size: 24)!
    static let NAMEFONT : UIFont = UIFont(name: "Inter-Bold", size: 16)!
    static let SUBTITLFONT : UIFont = UIFont(name: "Inter-Regular", size: 22)!
    static let TABBARITEMFONT : UIFont = UIFont(name: "Inter-Bold", size: 18)!
    static let SIGNALITEMTYPE : UIFont = UIFont(name: "Inter-Bold", size: 15)!
    static let SIGNALITEMVALUE : UIFont = UIFont(name: "Inter-Regular", size: 15)!
    static let SiGNALCAPTION : UIFont = UIFont(name: "Inter-Bold", size: 14)!
}

struct AppFontNames{
    
    static let InterRegular : String = "Inter-Regular"
    static let InterBold : String = "Inter-Regular"
    static let InterExtraLight: String = "Inter-ExtraLight"
    static let InterLight: String = "Inter-Light"
    static let InterMedium : String = "Inter-Medium"
    static let InterThin : String = "Inter-Thin"
    static let InterBlack : String = "Inter-Black"
    static let InterExtraBold : String = "Inter-ExtraBold"
    static let InterSemiBold : String = "Inter-SemiBold"
    static let HelveticaBold:String = "Helvetica-Bold"

}

struct AppTitles{
    static let NEXTBTNTEXT : String = "Next"
    static let NEEDHELPTEXT : String = "Need Support?"
    static let ChoosePairText : String = "Choose Pair "
    static let ChoosePairSubText : String = "(the most popular)"
}

struct NavBackbtnType {
    static var LOGIN : Int = 10
    static var SIDEMENU : Int = 20
}

struct NavBehaviorType {
    
    static let MENUTAPED : String = "SideMenuTaped"
    static let BACKBTNTAPED : String = "BackBtnTaped"
}

struct MenuItemHight{
    
    static let PROFILEITEM : CGFloat = 80
    static let GENERALITEM : CGFloat = 60
    static let HEADERITEM : CGFloat = 100
}

struct MenuItemIndex {
    
    static let PROFILE : String = "profile"
    static let HOME : String = "Home"
    static let INTRADAYSIGNAL : String = "Intraday signal"
    static let SWINGSIGNAL : String = "Swing singal"
    static let MARKETOUTLOOK : String = "Market outlook"
    static let SUPPORTCENTER : String = "Support center"
    static let PROFILEINFO : String = "Profile Info"
    static let CLOSE : String = "Menu Close"
}

struct TabItemTitle {
    static let RUNNING : String = "RUNNING"
    static let CLOSED : String = "CLOSED"
    static let SUMMARY : String = "SUMMARY"
}


struct DetailSInfoType {
    
    static let SIGNALID : String = "SIGNALID"
    static let CREATED : String = "CREATED"
    static let OPENPRICE : String = "OPEN PRICE"
    static let TAKEPROFIT1 : String = "TAKE PROFIT1"
    static let TAKEPROFIT2 : String = "TAKE PROFIT2"
    static let STOPLOSS : String = "STOPLOSS"
    static let MESSAGE : String = "MESSAGE"
}


struct GlobalVariables{
    
    static var LocationInfo:[String: [String]] = [:]
    static var selectedcountry: String = "Albania"
    static var currentUserInfo : UserInfo = UserInfo()
    static var usersImageFolder:String = "usersImage"
    static var selectedSignalSrc:String = DataSrcType.INTRADAYSIGNAL
    static var selectedStatus : String = StatusType.Running
    static var IAPflag:Bool = false
    
}


struct DataSrcType {
             
    static let SWINGSIGNAL = "SWINGSIGNAL"
    static let INTRADAYSIGNAL = "INTRADAYSIGNAL"
}

struct StatusType{
    
    static let Running = "running"
    static let Closed = "closed"
}

struct ActionType {
    static let BUY:String = "BUY"
    static let SELL:String = "SELL"
}

struct AppsMainInfo{
    static let AppName:String = "Blue Wave"
}

var safeAreaHeight:CGFloat = 0

struct Links {
    static let supportLink : String = "https://www.facebook.com/oppafaizz/"
    static let termsLink:String = "http://www.bluewaveapp.com/uncategorized/privacy-policy/"
}

struct IAPDescriptions{
    
    static let sixMonth:String = "Full focus for 6 month subscription for full signal of forex. More savers with 6 month subscription. Brilliant choice!"
    static let threeMonth:String = "Have a great experience with 3 month subscription for full signal of forex. More savers with 3 month subscription than 1 month"
    static let oneMonth:String = "1 month subscription for full signal of forex. More savers with 6 month Are you serious only want profit for only one month?"
}

var signalTitle:String = "Intraday Signal"
