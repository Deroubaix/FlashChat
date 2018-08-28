//
//  LogInViewController.swift
//  FlashChat
//
//  Created by Marisha Deroubaix on 23/08/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LogInViewController: UIViewController {

  @IBOutlet weak var emailTextfield: UITextField!
  
  @IBOutlet weak var passwordTextfield: UITextField!
  
  override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
  
  
  @IBAction func loginPressed(_ sender: UIButton) {
    
    SVProgressHUD.show()
    
    Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
      if error != nil {
        print(error!)
      } else {
        print("Log in successful!")
        
        SVProgressHUD.dismiss()
        
        self.performSegue(withIdentifier: "goToChat", sender: self)
      }
    }
  }


}
