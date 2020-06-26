//
//  MarketOutlookModel.swift
//  BlueWave
//
//  Created by FreeBird on 5/5/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import Foundation
import Firebase

struct MOLModel:Codable{
    
    let videoLink : String?
    let videoTitle : String?
    let subTitle : String?
    let created:Timestamp
    
    private enum CodingKeys: String,CodingKey {
        case videoLink = "link"
        case videoTitle = "title"
        case subTitle = "description"
        case created
    }
    
    
}


