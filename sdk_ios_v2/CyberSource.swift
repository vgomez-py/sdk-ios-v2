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
    @objc optional func authFinished(sessionId: String)
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
                return self.notifyErrorOnDelegate("Error on FraudDetectionAPI.getConfig")
            }
            
            guard let fraudDetectionConfig = fraudDetectionConfig else  {
                return self.notifyErrorOnDelegate("No fraudDetectionConfig on FraudDetectionAPI.getConfig response")
            }
            
            self.profile = TrustDefenderMobile(config: [
                    TDMOrgID: fraudDetectionConfig.orgId!,
                    TDMLocationServices: NSNumber(value: true)])
            
            self.profile?.doProfileRequest(callback: { (response) in
                // call custom delegation when session id is created
                guard let response = response else {
                    return self.notifyErrorOnDelegate("No response on TrustDefenderMobile.doProfileRequest")
                }
                
                guard response["profile_status"] as! Int == 1 else {
                    return self.notifyErrorOnDelegate("No profile_status on TrustDefenderMobile.doProfileRequest")
                }
                
                guard let sessionId = response["session_id"] as? String else {
                    return self.notifyErrorOnDelegate("No session_id on TrustDefenderMobile.doProfileRequest")
                }
                
                self.delegate?.authFinished!(sessionId: sessionId)
            })
        }
    }
    
    private func notifyErrorOnDelegate(_ errorString: String) {
        NSLog(errorString)
        self.delegate?.authFinished!(sessionId: "")
    }
}


