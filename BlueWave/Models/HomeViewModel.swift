//
//  HomeViewModel.swift
//  BlueWave
//
//  Created by FreeBird on 4/13/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import Foundation

class HomeViewModel{
    
    var crryExRateList:[String] = []
    
    func getCrryExRateList(){
        
        crryExRateList.removeAll()
        
        crryExRateList.append("")
        crryExRateList.append("AUDUSD")
        crryExRateList.append("EURGBP")
        crryExRateList.append("EURUSD")
        crryExRateList.append("GBPUSD")
        crryExRateList.append("NZDUSD")
        crryExRateList.append("USDJPY")
        crryExRateList.append("USDCHF")
        crryExRateList.append("USDCAD")
        crryExRateList.append("USDSGD")
        crryExRateList.append("USDCNY")
        crryExRateList.append("USDMXN")
        crryExRateList.append("XAUUSD")
        
        
    }
    
    func numberOfItem()->Int{
        
        return crryExRateList.count
    }
    
}
