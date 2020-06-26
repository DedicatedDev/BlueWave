//
//  PurchaseManager.swift
//  BlueWave
//
//  Created by FreeBird on 4/28/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import Foundation
import SwiftyStoreKit
import StoreKit
import NVActivityIndicatorView
import FirebaseAuth
import FirebaseFirestore

struct PerchaseInfo:Codable{
    
    let id:String?
    let price : String?
    let currencyType:String?
    let downloadable:Bool?
    let period:String?
    
    init(model:SKProduct){
        
        id = model.productIdentifier
        price = "\(model.price)"
        currencyType = model.priceLocale.currencySymbol
        downloadable = model.isDownloadable
        period = model.subscriptionPeriod.flatMap({ (result) -> String in
            
            return String(result.numberOfUnits)
        })
        
    }
    
    init(model:UserInfo){
        
        id = model.memberShipInfoIOS?.mainInfo?.id
        price = model.memberShipInfoIOS?.mainInfo?.price
        currencyType = model.memberShipInfoIOS?.mainInfo?.currencyType
        downloadable = model.memberShipInfoIOS?.mainInfo?.downloadable
        period = model.memberShipInfoIOS?.mainInfo?.period
        
    }
    
}


struct  MemberShipInfo:Codable {
    let memberShipInfoIOS:Receipt?
    
    init(model:Receipt) {
        memberShipInfoIOS = model
    }
}

struct Receipt:Codable{
    var mainInfo:PerchaseInfo?
    let autoRenewStatus:String?
    let quantity:String?
    let expireDate:String?
    let introOfferPeriod:String?
    let transactionId:String?
    let trialPeriod:String?
    let purchaseDate:String?
    let productId:String?
    let subscriptionPurchaseGroupId:String?

    enum CodingKeys:String,CodingKey {
       
       case autoRenewStatus = "auto_renew_status"
       case quantity
       case expireDate = "expires_date"
       case introOfferPeriod = "is_in_intro_offer_period"
       case transactionId = "transaction_id"
       case trialPeriod = "is_trial_period"
       case purchaseDate = "purchase_date"
       case productId = "product_id"
       case subscriptionPurchaseGroupId = "subscription_group_identifier"
       case mainInfo
    }
    
    init(model:[String:Any]){
        
        let pendingRenewableInfo = model["pending_renewal_info"] as! NSArray
        let tempInfo = pendingRenewableInfo.lastObject as? Dictionary<String,Any>
        autoRenewStatus = tempInfo?["auto_renew_status"] as? String
        
        let latestReceiptInfo = model["latest_receipt_info"] as! NSArray
        let finalReceipt = latestReceiptInfo.lastObject as? [String:Any]
        
        quantity = finalReceipt!["quantity"] as? String
        expireDate = finalReceipt!["expires_date"] as? String
        introOfferPeriod = finalReceipt!["is_in_intro_offer_period"] as? String
        transactionId = finalReceipt!["transaction_id"] as? String
        trialPeriod = finalReceipt!["is_trial_period"] as? String
        purchaseDate = finalReceipt!["purchase_date"] as? String
        productId = finalReceipt!["product_id"] as? String
        subscriptionPurchaseGroupId = finalReceipt!["subscription_group_identifier"] as? String
        
        
    }
}


enum PurchaseError: Error {
    case invalidCredential
    case badRequest
    case unknownError
    case decodingError
    case invalidRefreshToken
    case invalidToken
}

enum RegisteredPurchase : String {
    
    case sixMonth = "sixmonth"
    case threeMonth = "threemonth"
    case oneMonth = "onemonth"
}

let bundleID:String = "com.rashid.bluewave"

class IAPManager: NSObject {
    
    var purchaseKey:String?
    static let shared = IAPManager()
    
    let keychain = Keychain(service: "com.rashid.bluewave")
    
    override init() {
        
        super.init()
        guard let purchaseKey = keychain["accessToken"] else {
           return
        }
        
        self.purchaseKey = purchaseKey
    }
    
    
    func savePurchaseKey(purchaseKey:String ) {
        
        do {
            try keychain.set(purchaseKey, key: "purchaseKey", ignoringAttributeSynchronizable: false)
          
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
    func getInfo(completion: @escaping(Result<RetrieveResults,Error>)->()){
        
        let proIds = [bundleID + "." + RegisteredPurchase.sixMonth.rawValue, bundleID + "." + RegisteredPurchase.threeMonth.rawValue, bundleID + "." + RegisteredPurchase.oneMonth.rawValue]
           
           var productIds = Set<String>()
           for id in proIds{
               productIds.insert(id)
           }
        
        Spinner.start()
        SwiftyStoreKit.retrieveProductsInfo(productIds) { result in
            Spinner.stop()
    
            if result.error != nil {
                completion(.failure(result.error!))
                print(result.error?.localizedDescription as Any)
            }else{
                completion(.success(result))
            }
        }
        
    }
    

    func purchaseProduct(with product: SKProduct, completion: @escaping (Bool, String?, Bool) -> ()){
        Spinner.start()
        SwiftyStoreKit.purchaseProduct(product, quantity: 1, atomically: true) { result in
            switch result {
            case .success(let product):
                // fetch content from your server, then:
               
                
    
              //  print(product.product)
                
                self.verifyReceipt { (result) in
                    
                    switch result{
                        case.success(let receipt):
                            
                            self.updateServer(with: receipt) { (success) in
                                
                                Spinner.stop()
                                if success{
                                    if product.needsFinishTransaction {
                                        SwiftyStoreKit.finishTransaction(product.transaction)
                                        completion(true, "Success", true)
                                    } else {
                                        completion(true, "Something is wrong. Please contact support!", false)
                                    }
                                }
                            }
                            
                        case.error(error: let error):
                            Spinner.stop()
                            completion(true, error.localizedDescription, false)
                    }
                }

            case .error(let error):
                switch error.code {
                case .unknown:
                    print("Unknown error. Please contact support")
                    completion(false, "Something is wrong. Please contact support!", false)
                case .clientInvalid:
                    print("Not allowed to make the payment")
                    completion(false, "You are not allowed to make the payment.", false)
                case .paymentCancelled:
                    completion(false, nil, true)
                    break
                case .paymentInvalid:
                    print("The purchase identifier was invalid")
                    completion(false, "The product is invalid.", false)
                case .paymentNotAllowed:
                    print("The device is not allowed to make the payment")
                    completion(false, "The device is not allowed to make the payment", false)
                case .storeProductNotAvailable:
                    print("The product is not available in the current storefront")
                    completion(false, "The product is not available in the current store.", false)
                case .cloudServicePermissionDenied:
                    print("Access to cloud service information is not allowed")
                    completion(false, "Access to cloud service information is not allowed", false)
                case .cloudServiceNetworkConnectionFailed:
                    print("Could not connect to the network")
                    completion(false, "Could not connect to the network", false)
                case .cloudServiceRevoked:
                    print("User has revoked permission to use this cloud service")
                    completion(false, "User has revoked permission to use this cloud service", false)
                default:
                    print((error as NSError).localizedDescription)
                    completion(false, "Something is wrong. Please try later.", false)
                }
                Spinner.stop()
            }
        }
        
    }
    

    func verifyPurchase(with id: String, sharedSecret: String){
        
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
        
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                let productId = id
                // Verify the purchase of a Subscription
                let purchaseResult = SwiftyStoreKit.verifyPurchase(
                    productId: id,
                    inReceipt: receipt)
                
                switch purchaseResult {
                case .purchased(let receiptItem):
                    print("\(productId) is purchased: \(receiptItem)")
                case .notPurchased:
                    print("The user has never purchased \(productId)")
                }
                
            case .error(let error):
                print("Receipt verification failed: \(error)")
            }
        }
    
    }
    
    
    func restore(completion:@escaping(Result <RestoreResults,Error>)->()){
        
       Spinner.start()
       SwiftyStoreKit.restorePurchases(atomically: true) { results in
       Spinner.stop()

           for purchase in results.restoredPurchases {
               let downloads = purchase.transaction.downloads
               if !downloads.isEmpty {
                   SwiftyStoreKit.start(downloads)
               } else if purchase.needsFinishTransaction {
                   // Deliver content from server, then:
                   SwiftyStoreKit.finishTransaction(purchase.transaction)
               }
           }
        completion(.success(results))
       }
    }
    
    
    func verifySubscriptions(with purchases: Set<String>,completion:@escaping(String,Set<String>,Bool)->()) {
        
        Spinner.start()
        verifyReceipt { result in
            switch result {
            case .success(let receipt):
                print(result)
                let productIds = Set(purchases.map { bundleID + "." + $0 })
                let purchaseResult = SwiftyStoreKit.verifySubscriptions(productIds: productIds, inReceipt: receipt)

                switch purchaseResult {
                case .purchased(let expiryDate, _):
                   // print("\(productIds) are valid until \(expiryDate)\n\(items)\n")
                    self.updateServer(with: receipt) { (result) in
                        
                        Spinner.stop()
                        if result{
                             completion("You are valid until \(expiryDate)",productIds,true)
                            
                        }else{
                            completion("Something went wrong ...",[], false)
                        }
                    }
                    
                case .expired(let expiryDate, _):
                    //print("You are not purchased so far. Some")
                    Spinner.stop()
                    completion("You are expired since \(expiryDate)",productIds,false)
                case .notPurchased:
                    Spinner.stop()
                    completion("The user has never purchased",productIds,false)
                }
                
            case .error:
                Spinner.stop()
                completion("Something went wrong...",[],false)
            }
        }
    }
    
    

    func verifyReceipt(completion: @escaping (VerifyReceiptResult) -> Void) {
        
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: "6a8cf037fc284564ac545648006d8c39")
        SwiftyStoreKit.verifyReceipt(using: appleValidator, completion: completion)
    }
  
    
    
    func updateServer(with receipt:ReceiptInfo,completion:@escaping(Bool)->()){
        
      
        //var items:[PerchaseInfo] = []
        let breifReceipt = Receipt(model: receipt)
        
        self.getInfo { (result) in
                   
           switch result{
           case.success(let productInfos):
               //RetrieveResults
             let productInfos = productInfos.retrievedProducts
             
             for productInfo in productInfos{
            
                let item = PerchaseInfo(model: productInfo)
                if item.id == breifReceipt.productId{
                    
                    self.setDataToServer(mainInfo: item, receipt: receipt) { (success) in
                        completion(true)
                    }
                    completion(false)
                    break
                }
             }
            
            completion(false)
            
           case.failure(let err):
            completion(false)
            print(err.localizedDescription)
           }
                   
         }
        
    
//        let uid = Auth.auth().currentUser?.uid
//        let ref = Firestore.firestore().collection("users").document(uid!)
//        ref.getDocument { (document, error) in
//          if let error = error {
//              print(error.localizedDescription)
//
//              return
//            }
//
//          do {
//              try ref.setData(from: membershipInfo, merge: true)
//              completion(true)
//          } catch {
//              print(error.localizedDescription)
//              //completion(false)
//          }
//        }
        
        
       
    }
    
    
    func setDataToServer(mainInfo:PerchaseInfo,receipt:ReceiptInfo,completion:@escaping(Bool)->()){
        
        var receipt = Receipt(model: receipt)
        receipt.mainInfo = mainInfo
        
        let membershipInfo = MemberShipInfo(model: receipt)
        
        let uid = Auth.auth().currentUser?.uid
        guard uid != nil else {
            
        //    Utility.showMsgForResult(vc: self, title: "BlueWave", msgTxt: "Something went wrong")
            return
        }
        let ref = Firestore.firestore().collection("users").document(uid!)
        ref.getDocument { (document, error) in
          if let error = error {
              print(error.localizedDescription)
              completion(false)
              return
            }

          do {
              try ref.setData(from: membershipInfo, merge: true)
              completion(true)
          } catch {
              print(error.localizedDescription)
              completion(false)
          }
        }
    }
    
    
    
}




