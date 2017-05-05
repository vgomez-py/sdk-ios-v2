//
//  HomeViewController.swift
//  
//
//  Created by Maxi on 4/25/17.
//
//

import UIKit
import sdk_ios_v2

class HomeViewController: UIViewController, CyberSourceDelegate {
    
    var cyberSource:CyberSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.cyberSource = CyberSource()
        self.cyberSource?.delegate = self
        self.cyberSource?.auth(publicKey: "e9cdb99fff374b5f91da4480c8dca741")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func authFinished(sessionId: String) {
        NSLog("Session id created: %s", sessionId)
    }

    @IBAction func cardTokenButtonTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: "tokenPayment", sender: self)
    }
    
    @IBAction func defaultButtonTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: "defaultPayment", sender: self)
    }
    
}
