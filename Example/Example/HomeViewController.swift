//
//  HomeViewController.swift
//  
//
//  Created by Maxi on 4/25/17.
//
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cardTokenButtonTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: "tokenPayment", sender: self)
    }
    
    @IBAction func defaultButtonTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: "defaultPayment", sender: self)
    }
    
}
