//
// CardHolder.swift
//

import Foundation


open class PaymentCardToken: JSONEncodable {
    public var token: String?
    public var securityCode: String?
    public var fraudDetection: FraudDetection?
    
    public init() {
    
        self.token = ""
        self.securityCode = ""
    }
    
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["token"] = self.token
        nillableDictionary["security_code"] = self.securityCode
        nillableDictionary["fraud_detection"] = self.fraudDetection?.encodeToJSON()
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
