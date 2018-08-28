//
//  RegisterViewController.swift
//  FlashChat
//
//  Created by Marisha Deroubaix on 23/08/18.
//  Copyright © 2018 Marisha Deroubaix. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {

  @IBOutlet var emailTextfield: UITextField!
  
  @IBOutlet weak var passwordTextfield: UITextField!
  
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func registerPressed(_ sender: UIButton) {
    
    SVProgressHUD.show()
    
    Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
      if error != nil {
        print(error!)
      } else {
        print("Registration successful")
        
        SVProgressHUD.dismiss()
        
        self.performSegue(withIdentifier: "goToChat", sender: self)
      }
    }
    
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
