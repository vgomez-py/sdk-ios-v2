//
// CardHolder.swift
//

import Foundation


open class CardHolder: JSONEncodable {
    public var name: String?
    public var identification: CardHolderIdentification?
    public var birthday: String?
    public var nro_puerta: Double?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["name"] = self.name
        nillableDictionary["identification"] = self.identification?.encodeToJSON()
        nillableDictionary["birthday"] = self.birthday
        nillableDictionary["nro_puerta"] = self.nro_puerta
        
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
    
    open func toString() -> String {
        
        var cardHolderText = "[\n"
        
        cardHolderText += "name: \(self.name!) \n"
        cardHolderText += "identification: \(self.identification!.toString()) \n"
        cardHolderText += "birthday: \(self.birthday!) \n"
        cardHolderText += "nro_puerta: \(self.nro_puerta!) \n"
        
        cardHolderText += "]"
        
        return cardHolderText
    }
}
