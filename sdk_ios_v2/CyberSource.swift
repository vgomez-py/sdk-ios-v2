//
// CyberSource.swift
//
// This class allows you to obtain
// session id to sent in API requests
//
import UIKit
import TrustDefenderMobile

/*
 Delegate to ensure session id is created
 */
@objc public protocol CyberSourceDelegate{
    @objc optional func authFinished(sessionId:String)
}

open class CyberSource: UIViewController, CyberSourceDelegate {
    
    open var delegate:CyberSourceDelegate?
    var profile:TrustDefenderMobile?
    
    /*
     Auth to the API and generate session id
     
     - parameter publicKey: api key used to authorize the client (required)
     - parameter isSandbox: switch sandbox or production, if nil sandbox is used (optional)
     */
    open func auth(publicKey: String, isSandbox: Bool = false) {
        
        FraudDetectionAPI(publicKey: publicKey, isSandbox: isSandbox).getConfig { (fraudDetectionConfig, error) in
            
            guard error == nil else {
                NSLog("There was an error trying to get config")
                return
            }
            
            if let fraudDetectionConfig = fraudDetectionConfig {
            
                self.profile =
                    TrustDefenderMobile(config: [
                        TDMOrgID: fraudDetectionConfig.orgId!,
                        TDMDelegate: self,
                        TDMLocationServices: NSNumber(value: true)])
                
                self.profile?.doProfileRequest()
            
            }
        }
    }
    
    /*
     Delegate implementation that call custom delegation when 
     session id is created
     
     - parameter response: TrustDefender response
     */
    func profileComplete(_ response:[AnyHashable:Any]?) {
        
        if let response = response {
            
            guard response["profile_status"] as! Int == 1 else {
                NSLog("There was an error trying to request profile.")
                return
            }
            
            self.delegate?.authFinished!(sessionId:response["session_id"] as! String )
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
