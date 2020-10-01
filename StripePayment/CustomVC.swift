//
//  CustomVC.swift
//  StripePayment
//
//  Created by Harendra Sharma on 16/06/18.
//  Copyright © 2018 Harendra Sharma. All rights reserved.
//

import UIKit
import Stripe

class CustomVC: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var Expiry: UITextField!
    @IBOutlet weak var cvc: UITextField!
    @IBOutlet weak var msgBox: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Custom"
        // Do any additional setup after loading the view.
          msgBox.text = ""
        
       
        
        // Add payment card text field to view
    }

    @IBAction func PaymentTapped(_ sender: UIButton) {
         msgBox.text = ""
        let comps = Expiry.text?.components(separatedBy: "/")
        let f = UInt(comps!.first!)
        let l = UInt(comps!.last!)
        
        let cardParams = STPCardParams()
        cardParams.name = name.text!
        cardParams.number = number.text!
        cardParams.expMonth = f!
        cardParams.expYear =  l!
        cardParams.cvc = cvc.text!

        STPAPIClient.shared().createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
            print("Printing Strip response:\(String(describing: token?.allResponseFields))\n\n")
            print("Printing Strip Token:\(String(describing: token?.tokenId))")
            
            
            if error != nil {
                print(error?.localizedDescription ?? "")
            }
            
            if token != nil{
                self.msgBox.text = "Transaction success! \n\nHere is the Token: \(String(describing: token!.tokenId))\nCard Type: \(String(describing: token!.card!.funding))\n\nSend this token or detail to your backend server to complete this payment."
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
