//
// CardHolderIdentification.swift
//

import Foundation


open class CardHolderIdentification: JSONEncodable {
    public var type: String?
    public var number: String?

    public init() {
    
        self.type = ""
        self.number = ""
    }

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["type"] = self.type
        nillableDictionary["number"] = self.number
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
    
    open func toString() -> String {
        
        var cardHolderIdentificationText = "[\n"
        
        cardHolderIdentificationText += "type: \(self.type!) \n"
        cardHolderIdentificationText += "number: \(self.number!) \n"
        
        cardHolderIdentificationText += "]"
        
        return cardHolderIdentificationText
    }
}
