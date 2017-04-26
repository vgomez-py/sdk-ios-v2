//
// PaymentsTokenAPI.swift
//
//

import Alamofire



open class PaymentsTokenAPI: APIBase {
    
    static let PATH = "/tokens"
    
    var publicKey: String
    var isSandbox: Bool
    
    public init(publicKey: String, isSandbox: Bool = false) {
        
        self.publicKey = publicKey
        
        self.isSandbox = isSandbox
    }
    
    open static var publicKey:String?

    /**
     Creates a new payment token
     
     - parameter paymentTokenInfo: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open func createPaymentToken(paymentTokenInfo: PaymentTokenInfo? = nil, completion: @escaping ((_ data: PaymentToken?,_ error: Error?) -> Void)) {
        self.tokensPostWithRequestBuilder(paymentTokenInfo: paymentTokenInfo).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    open func createPaymentTokenWithCardToken(paymentTokenInfoWithCardToken: PaymentTokenInfoWithCardToken? = nil, completion: @escaping ((_ data: PaymentToken?,_ error: Error?) -> Void)) {
        self.tokensPostWithCardTokenRequestBuilder(paymentTokenInfoWithCardToken: paymentTokenInfoWithCardToken).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }
    

    /**
     
     - parameter paymentTokenInfo: (body)  (optional)

     - returns: RequestBuilder<PaymentToken> 
     */
    open func tokensPostWithRequestBuilder(paymentTokenInfo: PaymentTokenInfo? = nil) -> RequestBuilder<PaymentToken> {
        
        let parameters = paymentTokenInfo?.encodeToJSON() as? [String:AnyObject]

        return proceedPayment(parameters: parameters)
    }
    
    open func tokensPostWithCardTokenRequestBuilder(paymentTokenInfoWithCardToken: PaymentTokenInfoWithCardToken? = nil) -> RequestBuilder<PaymentToken>  {
        let parameters = paymentTokenInfoWithCardToken?.encodeToJSON() as? [String:AnyObject]
        
        return proceedPayment(parameters: parameters)
    }
    
    open func proceedPayment(parameters: [String:AnyObject]? = nil) -> RequestBuilder<PaymentToken> {
        
        
        let URLString = DecClientAPI.getBasePath(isSandbox: self.isSandbox) + PaymentsTokenAPI.PATH
        
        let url = NSURLComponents(string: URLString)
        
        
        let requestBuilder: RequestBuilder<PaymentToken>.Type = DecClientAPI.requestBuilderFactory.getBuilder()
        
        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true, headers: ["apikey": self.publicKey])
    }
}
