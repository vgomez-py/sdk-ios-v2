//
// FraudDetectionAPI.swift
//
// This class allows you to obtain
// fraud detection config.
//
import Alamofire

open class FraudDetectionAPI: APIBase {
    
    static let PATH = "/frauddetectionconf"
    
    var publicKey: String
    var isSandbox: Bool
  
    /**
     Init
     
     - parameter publicKey: api key used to authorize the client (required)
     - parameter isSandbox: switch sandbox or production, if nil sandbox is used (optional)
     */
    public init(publicKey: String, isSandbox: Bool = false) {
        self.publicKey = publicKey
        self.isSandbox = isSandbox
    }
    
    /**
     Get fraud detection config
     
     - parameter completion: completion handler to receive the data and the error objects
     */
    open func getConfig(completion: @escaping ((_ data: FraudDetectionConfig?,_ error: Error?) -> Void)) {
        self.getConfigWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }
    
    /**
     Creates a request builder for fraud detection config
    
     - returns: RequestBuilder<FraudDetectionConfig>
     */
    open func getConfigWithRequestBuilder() -> RequestBuilder<FraudDetectionConfig> {
        let URLString = DecClientAPI.getBasePath(isSandbox: self.isSandbox) + FraudDetectionAPI.PATH
        let url = NSURLComponents(string: URLString)
        let requestBuilder: RequestBuilder<FraudDetectionConfig>.Type = DecClientAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: nil, isBody: false, headers: ["apikey": self.publicKey])
    }
}

