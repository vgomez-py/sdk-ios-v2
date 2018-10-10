// APIs.swift
//
//

import Foundation

open class DecClientAPI {
    public static var basePathSandbox = "https://developers.decidir.com/api/v1"
    public static var basePathProduction = "https://live.decidir.com/api/v1"
    public static var customHeaders: [String:String] = [:]
    static var requestBuilderFactory: RequestBuilderFactory = AlamofireRequestBuilderFactory()
    
    open class func getBasePath(isSandbox: Bool = false) -> String {
        
        return isSandbox ? DecClientAPI.basePathSandbox : DecClientAPI.basePathProduction
    }
}

open class APIBase {
    func toParameters(_ encodable: JSONEncodable?) -> [String: Any]? {
        let encoded: Any? = encodable?.encodeToJSON()

        if encoded! is [Any] {
            var dictionary = [String:Any]()
            for (index, item) in (encoded as! [Any]).enumerated() {
                dictionary["\(index)"] = item
            }
            return dictionary
        } else {
            return encoded as? [String:Any]
        }
    }
}

open class RequestBuilder<T> {
    var headers: [String:String]
    let parameters: [String:Any]?
    let isBody: Bool
    let method: String
    let URLString: String
    
    /// Optional block to obtain a reference to the request's progress instance when available.
    public var onProgressReady: ((Progress) -> ())?

    required public init(method: String, URLString: String, parameters: [String:Any]?, isBody: Bool, headers: [String:String] = [:]) {
        self.method = method
        self.URLString = URLString
        self.parameters = parameters
        self.isBody = isBody
        self.headers = headers
        
        addHeaders(DecClientAPI.customHeaders)
    }
    
    open func addHeaders(_ aHeaders:[String:String]) {
        for (header, value) in aHeaders {
            headers[header] = value
        }
    }
    
    open func execute(_ completion: @escaping (_ response: Response<T>?, _ error: Error?) -> Void) { }

    public func addHeader(name: String, value: String) -> Self {
        if !value.isEmpty {
            headers[name] = value
        }
        return self
    }
}

public protocol RequestBuilderFactory {
    func getBuilder<T>() -> RequestBuilder<T>.Type
}

