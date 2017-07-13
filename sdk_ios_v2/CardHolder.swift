//
// CardHolder.swift
//

import Foundation


open class CardHolder: JSONEncodable {
    public var name: String?
    public var identification: CardHolderIdentification?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["name"] = self.name
        nillableDictionary["identification"] = self.identification?.encodeToJSON()
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
