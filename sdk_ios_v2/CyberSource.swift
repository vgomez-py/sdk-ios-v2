//
//  CyberSourceProtocol
//

import UIKit
import TrustDefenderMobile

@objc public protocol CyberSourceDelegate{
    @objc optional func authFinished(sessionId:String)
}

open class CyberSource: UIViewController, CyberSourceDelegate {
    
    // this is where we declare our protocol
    open var delegate:CyberSourceDelegate?
    var profile:TrustDefenderMobile?
    
    open func auth(apiKey: String, isSandbox: Bool = false) {
        
        FraudDetectionAPI(publicKey: apiKey, isSandbox: isSandbox).getConfig { (fraudDetectionConfig, error) in
            
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
