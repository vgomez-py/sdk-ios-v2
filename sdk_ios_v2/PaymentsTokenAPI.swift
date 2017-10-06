//
// PaymentsTokenAPI.swift
//
// This class allows you to generate
// payment token or card payment token.
//

import Alamofire

open class PaymentsTokenAPI: APIBase {
    
    static let PATH = "/tokens"
    
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
     Creates a new payment token
     
     - parameter paymentToken: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open func createPaymentToken(paymentToken: PaymentToken? = nil, completion: @escaping ((_ data: PaymentTokenResponse?,_ error: Error?) -> Void)) {
        self.tokensPostWithRequestBuilder(paymentToken: paymentToken).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }

    /**
     Creates a new payment card token
     
     - parameter paymentCardToken: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open func createPaymentCardToken(paymentCardToken: PaymentCardToken? = nil, completion: @escaping ((_ data: PaymentTokenResponse?,_ error: Error?) -> Void)) {
        self.tokensCardPostWithRequestBuilder(paymentCardToken: paymentCardToken).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }
    
    /**
     Creates a new payment offline token
     
     - parameter paymentOfflineToken: (body)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open func createPaymentOfflineToken(paymentTokenOffline: PaymentTokenOffline? = nil, completion: @escaping ((_ data: PaymentTokenResponse?,_ error: Error?) -> Void)) {
        self.tokensOfflinePostWithRequestBuilder(paymentTokenOffline: paymentTokenOffline).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }
    
    /**
     Creates a request builder for payment token
     
     - parameter paymentToken: (body)  (optional)
     - returns: RequestBuilder<PaymentTokenResponse>
     */
    func tokensPostWithRequestBuilder(paymentToken: PaymentToken? = nil) -> RequestBuilder<PaymentTokenResponse> {
        let parameters = paymentToken?.encodeToJSON() as? [String:AnyObject]
        return proceedPayment(parameters: parameters)
    }
    
    /**
     Creates a request builder for payment card token
     
     - parameter paymentCardToken: (body)  (optional)
     - returns: RequestBuilder<PaymentTokenResponse>
     */
    func tokensCardPostWithRequestBuilder(paymentCardToken: PaymentCardToken? = nil) -> RequestBuilder<PaymentTokenResponse>  {
        let parameters = paymentCardToken?.encodeToJSON() as? [String:AnyObject]
        return proceedPayment(parameters: parameters)
    }
    
    /**
     Creates a request builder for payment offline token
     
     - parameter paymentOfflineToken: (body)  (optional)
     - returns: RequestBuilder<PaymentTokenResponse>
     */
    func tokensOfflinePostWithRequestBuilder(paymentTokenOffline: PaymentTokenOffline? = nil) -> RequestBuilder<PaymentTokenResponse>  {
        let parameters = paymentTokenOffline?.encodeToJSON() as? [String:AnyObject]
        return proceedPayment(parameters: parameters)
    }
    
    /**
     Executes both requests payment or payment card
     
     - parameter parameters: (body)  (optional)
     - returns: RequestBuilder<PaymentTokenResponse>
     */
    func proceedPayment(parameters: [String:AnyObject]? = nil) -> RequestBuilder<PaymentTokenResponse> {
        
        let URLString = DecClientAPI.getBasePath(isSandbox: self.isSandbox) + PaymentsTokenAPI.PATH
        let url = NSURLComponents(string: URLString)
        let requestBuilder: RequestBuilder<PaymentTokenResponse>.Type = DecClientAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true, headers: ["apikey": self.publicKey])
    }
}
