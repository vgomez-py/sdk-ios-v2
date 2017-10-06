//
//  Lala.swift
//

import Foundation

open class PaymentTokenOffline: JSONEncodable {
    public var customer: Customer?
    
    public init() {}
    
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["customer"] = self.customer?.encodeToJSON()
        
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
    
    open func toString() -> String {
        
        var cardHolderText = "[\n"
        
        cardHolderText += "customer: \(self.customer!.toString()) \n"
        
        cardHolderText += "]"
        
        return cardHolderText
    }
}
