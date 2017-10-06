//
//  OfflineTokenViewController.swift
//  Example
//
//  Created by Maxi on 10/6/17.
//  Copyright © 2017 Prisma Medios de Pago. All rights reserved.
//

import UIKit
import sdk_ios_v2

class OfflineTokenViewController: UIViewController, UITextFieldDelegate {
    
    var sessionId: String?

    @IBOutlet weak var holderName: UITextField!
    @IBOutlet weak var docType: UITextField!
    @IBOutlet weak var docNumber: UITextField!
    @IBOutlet weak var textLabel: UILabel!
    
    var paymentTokenApi:PaymentsTokenAPI = PaymentsTokenAPI(publicKey: "e9cdb99fff374b5f91da4480c8dca741", isSandbox: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        holderName.delegate = self
        docType.delegate = self
        docNumber.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func payButtonTapped(_ sender: UIButton) {
        let pti = PaymentTokenOffline()
    
        pti.customer = Customer()
        pti.customer?.name = holderName.text
        
        let holder = CardHolderIdentification()
        holder.type = docType.text
        holder.number = docNumber.text
        
        pti.customer?.identification = holder
        
        self.paymentTokenApi.createPaymentOfflineToken(paymentTokenOffline: pti) { (paymentToken, error) in
            
            guard error == nil else {
                
                if case let ErrorResponse.Error(_, _, dec as ModelError) = error! {
                    
                    self.textLabel.text = dec.toString()
                    
                }
                return
            }
            
            if let paymentToken = paymentToken {
                self.textLabel.text = paymentToken.toString()
            }
        }

    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
