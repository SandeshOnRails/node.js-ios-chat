//
//  RegisterViewController.swift
//  chat
//
//  Created by Sandesh Basnet on 9/26/18.
//  Copyright © 2018 Sandesh Basnet. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var registerUserName: UITextField!
    
    
    @IBOutlet weak var registerEmail: UITextField!
    
    
    @IBOutlet weak var registerPassword: UITextField!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func regsiterButtonClicked(_ sender: UIButton) {
        
         let username = self.registerUserName.text!
         let password = self.registerPassword.text!
         let email = self.registerEmail.text!
        
        if username.isEmpty || password.isEmpty || email.isEmpty {
            self.errorLabel.text = "*Please enter all the information below"
        }
        else {
            registerUser()
        }
        
    }
    
    
    func registerUser () {
        
        let user = PFUser()
        user.username = self.registerUserName.text!
        user.email = self.registerEmail.text!
        user.password = self.registerPassword.text!
        
        user.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                
            }
        }
        
    }
}
