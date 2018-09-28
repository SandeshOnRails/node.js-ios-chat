//
//  ViewController.swift
//  chat
//
//  Created by Sandesh Basnet on 9/23/18.
//  Copyright © 2018 Sandesh Basnet. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    
    @IBOutlet weak var loginUserName: UITextField!
    
    @IBOutlet weak var loginPassword: UITextField!
    
    var cipher: Cipher!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        
          cipher = ROT13()
          let username = loginUserName.text!
          let password = cipher.encode(loginPassword.text!)
        
        if(username.isEmpty || password.isEmpty) {
            
            self.errorLabel.text = "*Please provide usernname and pasword"
        }
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                self.errorLabel.text = ""
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
                
            }
        }
        
        
        
    }
    

}

