//
// ModelError.swift
//

import Foundation


open class ModelError: JSONEncodable, Error {
    public var errorType: String?
    public var validationErrors: [ValidationError]?
    public var status: String?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["error_type"] = self.errorType
        nillableDictionary["validation_errors"] = self.validationErrors?.encodeToJSON()
        nillableDictionary["status"] = self.status
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
    
    open func toString() -> String {
        
        var validationText = "[\n"
        
        if let errorType = self.errorType {
                validationText += "errorType: \(errorType) \n"
        }
        
        
        if let validationErrors = self.validationErrors {
            validationErrors.forEach({ (validationError) in
                validationText += "param: \(validationError.toString()) \n"
            })
        }
        
        if let status = self.status {
            validationText += "status: \(status) \n"
        }
        
        
        validationText += "]"
        
        return validationText
    }
}
