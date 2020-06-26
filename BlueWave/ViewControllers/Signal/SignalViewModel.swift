//
//  SignalViewModel.swift
//  BlueWave
//
//  Created by FreeBird on 4/22/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SignalViewModel{
    
    var runningSignals:[SignalModel] = []
    var closedSignals : [SignalModel] = []
    
    func getSignals(srcType:String,completion: @escaping (Bool, String) -> ()) {
        
        var collectionName = "intraday_signals"
        
        if srcType == DataSrcType.SWINGSIGNAL{
            collectionName = "swing_signals"
        }
            
        if Reachability.isConnectedToNetwork() {
            
            let db = Firestore.firestore()
            db.collection(collectionName)
            .getDocuments() { (querySnapshot, err) in
                if err != nil {
                    print("Error getting documents: \(String(describing: err?.localizedDescription))")
                } else {
                    
                    self.closedSignals.removeAll()
                    self.runningSignals.removeAll()
                    
                    for document in querySnapshot!.documents {
                        
                        print(document.data())
                        do {
                            guard let signal: SignalModel = try document.data(as: SignalModel.self) else {return}
                             
                            if signal.flagClosed!{
                                self.closedSignals.append(signal)
                            }else{
                                self.runningSignals.append(signal)
                            }
                            
                            print(self.runningSignals)
                            
                        } catch {
                            print(error)
                          // completion(false,"We will get back you soon!")
                        }
                        
                        self.closedSignals.sort{$0.closed! > $1.closed!}
                        self.runningSignals.sort{$0.created! > $1.created!}
                        
                    }
                    completion(true,"ok")
                }
            }
        }
        else
        {
            completion (false, "NoInternet")
        }
            
    }
        
}
