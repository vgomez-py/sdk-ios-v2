//
// PaymentToken.swift
//

import Foundation


open class PaymentToken: JSONEncodable {
    public var id: String?
    public var status: String?
    public var cardNumberLength: Double?
    public var dateCreated: String?
    public var bin: String?
    public var lastFourDigits: String?
    public var securityCodeLength: Double?
    public var expirationMonth: Double?
    public var expirationYear: Double?
    public var dateDue: String?
    public var cardholder: CardHolder?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["id"] = self.id
        nillableDictionary["status"] = self.status
        nillableDictionary["card_number_length"] = self.cardNumberLength
        nillableDictionary["date_created"] = self.dateCreated
        nillableDictionary["bin"] = self.bin
        nillableDictionary["last_four_digits"] = self.lastFourDigits
        nillableDictionary["security_code_length"] = self.securityCodeLength
        nillableDictionary["expiration_month"] = self.expirationMonth
        nillableDictionary["expiration_year"] = self.expirationYear
        nillableDictionary["date_due"] = self.dateDue
        nillableDictionary["cardholder"] = self.cardholder?.encodeToJSON()
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
    
    open func toString() -> String {
        
        var paymentTokenText = "[\n"
        
        paymentTokenText += "id: \(self.id!) \n"
        paymentTokenText += "status: \(self.status!) \n"
        paymentTokenText += "bin: \(self.bin!) \n"
        paymentTokenText += "lastFourDigits: \(self.lastFourDigits!) \n"
        paymentTokenText += "dateCreated \(self.dateCreated!) \n"
        paymentTokenText += "dateDue \(self.dateDue!) \n"
        
        
        paymentTokenText += "]"
        
        return paymentTokenText
    }
}

