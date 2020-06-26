//
//  GlobalModel.swift
//  BlueWave
//
//  Created by FreeBird on 4/12/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import Foundation
import UIKit

struct DeviceSize {
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
}

struct ValidateAnchor{
    
    var top:Bool = true
    var bottom:Bool = true
    var lead: Bool = true
    var trail: Bool = true
}


struct UserProfile{
    
    var userName : String = ""
    var userPhonenumber : String =  ""
    var userEmail : String = ""
    var userPassword : String = ""
    var userCountry : String = ""
    var userCity : String = ""
    var userAddress : String = ""
}




struct SignalModel:Codable {
    var signalId : String?
    var pair : String?
    var action : Bool?
    var openPrice : String?
    var created :Date?
    var closed:Date?
    var tp1 : String?
    var tp2 : String?
    var stopLoss : String?
    var message : String?
    var flagClosed:Bool?
    var imgUrl:String?
}


