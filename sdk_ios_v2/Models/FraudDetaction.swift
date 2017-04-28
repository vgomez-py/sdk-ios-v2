//
// FraudDetaction.swift
//

import Foundation


open class FraudDetaction: JSONEncodable {
    public var deviceUniqueIdentifier: String?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["device_unique_identifier"] = self.deviceUniqueIdentifier
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
