//
//  Customer.swift
//  sdk_ios_v2
//
//  Created by Maxi on 10/6/17.
//  Copyright © 2017 Prisma Medios de Pago. All rights reserved.
//

import Foundation

open class Customer: JSONEncodable {
    
    public var name: String?
    public var identification: CardHolderIdentification?
    
    public init () {}
    
    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["name"] = self.name
        nillableDictionary["identification"] = self.identification?.encodeToJSON()
        
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
    
    open func toString() -> String {
        
        var cardHolderText = "[\n"
        
        cardHolderText += "name: \(self.name!) \n"
        cardHolderText += "identification: \(self.identification!.toString()) \n"
        
        cardHolderText += "]"
        
        return cardHolderText
    }

}
