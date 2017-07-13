//
// ValidationError.swift
//

import Foundation


open class ValidationError: JSONEncodable {
    public var code: String?
    public var param: String?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["code"] = self.code
        nillableDictionary["param"] = self.param
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
    
    open func toString() -> String {
        
        var validationText = "[\n"
        
        validationText += "code: \(self.code!) \n"
        validationText += "param: \(self.param!) \n"
        
        validationText += "]"
        
        return validationText
    }
}
