//
//  SBModelView.swift
//  BlueWave
//
//  Created by FreeBird on 4/13/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import Foundation


class SignalBModel{
    
    var signalSrc : [SignalModel] = []
    var tableViewData:[ExpandableData] = []
    var dateNumber : Int = 0
    
    struct ExpandableData{
        
        var isExpand: Bool = false
        var cellData:[SignalItem] = []
    }

    func numberOfSignal() -> Int {
    
        return signalSrc.count
    }
    
    func numberOfItemAtSignal(section:Int) ->Int{
        
        if !tableViewData[section].isExpand {
            return 0
        }
        
        return tableViewData[section].cellData.count
    }
    

    func getDataBySection(section : Int) ->SignalModel{
        
        var obj = SignalModel()
        obj = signalSrc[section]
        
        return obj
    }
    
    func createTableViewData(){

        var cellData:[SignalItem] = []

        for item in signalSrc{

            print(signalSrc)
            
    
            var obj = SignalItem()

            cellData.removeAll()

            //signal

            obj.type = DetailSInfoType.SIGNALID
            obj.value = item.signalId ?? ""
            cellData.append(obj)

            //created Data

            obj.type = DetailSInfoType.CREATED
            obj.value = item.created?.asString() ?? ""
            cellData.append(obj)

            // openprice

            obj.type = DetailSInfoType.OPENPRICE
            obj.value = item.openPrice ?? ""
            cellData.append(obj)

            //take profilt1

            obj.type = DetailSInfoType.TAKEPROFIT1
            obj.value = item.tp1 ?? ""
            cellData.append(obj)

            //take profit2

            obj.type = DetailSInfoType.TAKEPROFIT2
            obj.value = item.tp2 ?? ""
            cellData.append(obj)

            //stopLoss

            obj.type = DetailSInfoType.STOPLOSS
            obj.value = item.stopLoss ?? ""
            cellData.append(obj)

            //message

            obj.type = DetailSInfoType.MESSAGE
            obj.value = item.message ?? ""
            obj.imagUrl = item.imgUrl
            cellData.append(obj)
            
            //action
            
            var expandableData = ExpandableData()
            expandableData.cellData = cellData

            tableViewData.append(expandableData)

        }

       
        
    }
    
    func setDataForCell(cell:SItemCell, section:Int, index:Int){
        
 
        let obj = tableViewData[section].cellData[index]
        cell.setDataHere(obj: obj)
        
    }
    
    func setDataForCell(cell:MessageCell, section:Int, index:Int){
       

       let obj = tableViewData[section].cellData[index]
       cell.setDataHere(obj: obj)
       
   }
    func prepareData(obj:[SignalModel]) {
      //  generateTestData()
        
        self.signalSrc = obj
        createTableViewData()
    
    }

}
