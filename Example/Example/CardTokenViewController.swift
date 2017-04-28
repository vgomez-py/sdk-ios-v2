//
//  CardTokenViewController.swift
//  
//
//  Created by Maxi on 4/25/17.
//
//

import UIKit
import sdk_ios_v2

class CardTokenViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var cardToken: UITextField!
    @IBOutlet weak var securityCode: UITextField!
    @IBOutlet weak var responseLabel: UILabel!
    
    var paymentTokenApi:PaymentsTokenAPI = PaymentsTokenAPI(publicKey: "e9cdb99fff374b5f91da4480c8dca741", isSandbox: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardToken.delegate = self
        securityCode.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func proceedPayment(_ sender: UIButton) {
        let pti = PaymentTokenInfoWithCardToken()
        pti.token = cardToken.text
        pti.securityCode = securityCode.text
        
        self.paymentTokenApi.createPaymentTokenWithCardToken(paymentTokenInfoWithCardToken: pti) { (paymentToken, error) in
            
            guard error == nil else {
                
                if case let ErrorResponse.Error(_, _, dec as ModelError) = error! {
                    
                      self.responseLabel.text = dec.toString()
                    
                }
                return
            }
            
            if let paymentToken = paymentToken {
                self.responseLabel.text = paymentToken.toString()
            }
        }

    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
}
