//
// PaymentTokenInfo.swift
//


import Foundation


open class PaymentToken: JSONEncodable {
    public var cardNumber: String?
    public var cardExpirationMonth: String?
    public var cardExpirationYear: String?
    public var securityCode: String?
    public var cardHolderName: String?
    public var cardHolderIdentification: CardHolderIdentification?
    public var cardHolderBirthday: String?
    public var cardHolderDoorNumber: Double?
    public var fraudDetection: FraudDetection?

    public init() {
    
        self.cardNumber = ""
        self.cardExpirationMonth = ""
        self.cardExpirationYear = ""
        self.securityCode = ""
        self.cardHolderName = ""
        self.cardHolderIdentification = CardHolderIdentification()
        self.cardHolderBirthday = ""
        self.cardHolderDoorNumber = 0
        self.fraudDetection = FraudDetection()
    }

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["card_number"] = self.cardNumber
        nillableDictionary["card_expiration_month"] = self.cardExpirationMonth
        nillableDictionary["card_expiration_year"] = self.cardExpirationYear
        nillableDictionary["security_code"] = self.securityCode
        nillableDictionary["card_holder_name"] = self.cardHolderName
        nillableDictionary["card_holder_identification"] = self.cardHolderIdentification?.encodeToJSON()
        nillableDictionary["card_holder_birthday"] = self.cardHolderBirthday
        nillableDictionary["card_holder_door_number"] = self.cardHolderDoorNumber
        nillableDictionary["fraud_detection"] = self.fraudDetection?.encodeToJSON()
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
