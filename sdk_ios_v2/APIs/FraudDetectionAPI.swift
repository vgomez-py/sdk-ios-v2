//
//  FraudDetectionAPI.swift
//  sdk_ios_v2
//
//  Created by Maxi on 5/3/17.
//  Copyright © 2017 Prisma Medios de Pago. All rights reserved.
//

import Alamofire

open class FraudDetectionAPI: APIBase {
    
    static let PATH = "/frauddetectionconf"
    
    var publicKey: String
    var isSandbox: Bool
    
    public init(publicKey: String, isSandbox: Bool = false) {
        
        self.publicKey = publicKey
        
        self.isSandbox = isSandbox
    }
    
    open static var publicKey:String?
    
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
     - returns: RequestBuilder
     */
    open func getConfigWithRequestBuilder() -> RequestBuilder<FraudDetectionConfig> {
        
        let URLString = DecClientAPI.getBasePath(isSandbox: self.isSandbox) + FraudDetectionAPI.PATH
        
        let url = NSURLComponents(string: URLString)
        
        
        let requestBuilder: RequestBuilder<FraudDetectionConfig>.Type = DecClientAPI.requestBuilderFactory.getBuilder()
        
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: nil, isBody: false, headers: ["apikey": self.publicKey])
    }
}

