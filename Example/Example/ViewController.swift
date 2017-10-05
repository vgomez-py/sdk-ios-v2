//
//  ViewController.swift
//  DEC2_sdk_ios
//
//  Created by Maxi Britez on 04/25/2017.
//  Copyright (c) 2017 Maxi Britez. All rights reserved.
//

import UIKit
import sdk_ios_v2

class ViewController: UIViewController, UITextFieldDelegate, CyberSourceDelegate {
    
    var cyberSource:CyberSource?
    var sessionId: String?

    //MARK: Properties
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var expirationMonth: UITextField!
    @IBOutlet weak var expirationYear: UITextField!
    @IBOutlet weak var securityCode: UITextField!
    @IBOutlet weak var cardHolderName: UITextField!
    @IBOutlet weak var docType: UITextField!
    @IBOutlet weak var docNumber: UITextField!
    @IBOutlet weak var textResult: UILabel!
    
    var paymentTokenApi:PaymentsTokenAPI = PaymentsTokenAPI(publicKey: "e9cdb99fff374b5f91da4480c8dca741", isSandbox: true)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cardNumber.delegate = self
        expirationMonth.delegate = self
        expirationYear.delegate = self
        securityCode.delegate = self
        cardHolderName.delegate = self
        docType.delegate = self
        docNumber.delegate = self
        
        self.cyberSource = CyberSource()
        self.cyberSource?.delegate = self
        self.cyberSource?.auth(publicKey: "e9cdb99fff374b5f91da4480c8dca741", isSandbox: true)
        
    }
    
    func authFinished(sessionId: String) {
        NSLog("Session id created: %s", sessionId)
        self.sessionId = sessionId
    }
    
    @IBAction func proceedPayment(_ sender: UIButton) {
        let pti = PaymentToken()
        pti.cardNumber = cardNumber.text
        pti.cardExpirationMonth = expirationMonth.text
        pti.cardExpirationYear = expirationYear.text
        pti.cardHolderName = cardHolderName.text
        pti.securityCode = securityCode.text
        pti.fraudDetection = FraudDetection()
        pti.fraudDetection!.deviceUniqueIdentifier = self.sessionId
        
        let holder = CardHolderIdentification()
        holder.type = docType.text
        holder.number = docNumber.text
        
        pti.cardHolderDoorNumber = 3
        pti.cardHolderBirthday = "16082017"
        
        pti.cardHolderIdentification = holder
        
        self.paymentTokenApi.createPaymentToken(paymentToken: pti) { (paymentToken, error) in
            
            guard error == nil else {
                
                if case let ErrorResponse.Error(_, _, dec as ModelError) = error! {
                    
                    self.textResult.text = dec.toString()
                    
                }
                return
            }
            
            if let paymentToken = paymentToken {
                self.textResult.text = paymentToken.toString()
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    

}

