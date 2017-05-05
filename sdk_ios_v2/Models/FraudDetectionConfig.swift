//
//  FraudDetectionConfig.swift
//  sdk_ios_v2
//
//  Created by Maxi on 5/3/17.
//  Copyright © 2017 Prisma Medios de Pago. All rights reserved.
//

import Foundation

open class FraudDetectionConfig: JSONEncodable {
    
    public var orgId: String?
    public var merchantId: String?
    
    public init() {}
    
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["org_id"] = self.orgId
        nillableDictionary["merchant_id"] = self.merchantId
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
    
    open func toString() -> String {
        
        var paymentTokenText = "[\n"
        paymentTokenText += "org_id: \(self.orgId!) \n"
        paymentTokenText += "merchant_id: \(self.merchantId!) \n"
        paymentTokenText += "]"
        
        return paymentTokenText
    }
}


