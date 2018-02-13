//
//  LoginVC.swift
//  Grocery
//
//  Created by Melody on 12/10/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import UIKit
import KeychainSwift

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let keychain = KeychainSwift()
    var basicAuth = ""
    
    @IBAction func signUpPressed(_ sender: Any) {
        setKeychainCredential()
        let username = keychain.get("email")!
        let password = keychain.get("password")!
        
        basicAuth = BasicAuth.generateBasicAuthHeader(username: username , password: password)
        keychain.set(basicAuth, forKey: "BasicAuth")
        let user = User(email: username, password: password)
        
        Networking.shared.fetch(route: .createUser, data: user, params: [:]) { _ in
            if Networking.shared.statusCode == 409 {
                print("User exists")
                DispatchQueue.main.async {
                    self.informSignUpFailure()
                }
            } else {
                self.switchTabBarVC()
            }
            
        }
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        setKeychainCredential()
        
        let username = keychain.get("email")!
        let password = keychain.get("password")!
        let param = ["email": "\(keychain.get("email")!)"]
        
        basicAuth = BasicAuth.generateBasicAuthHeader(username: username , password: password)
        keychain.set(basicAuth, forKey: "BasicAuth")
        
        Networking.shared.fetch(route: .getUser, data: nil, params: param) { _ in
            if Networking.shared.statusCode == 500 {
                print("login failed")
                DispatchQueue.main.async {
                    self.informLoginFailure()
                }
                
            } else {
                self.switchTabBarVC()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

extension LoginVC {
    
    func setKeychainCredential() {
        keychain.set(emailField.text!, forKey: "email")
        keychain.set(passwordField.text!, forKey: "password")
    }
    
    func switchTabBarVC() {
        UserDefaults.standard.set(true, forKey: "loggedIn")
        
        DispatchQueue.main.async {
            let initialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarVC") as! UITabBarController
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
    }
    
    func informLoginFailure() {
        let alertController = UIAlertController(title: "Login Failed", message: "Wrong email or password", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(ok)
        self.present(alertController, animated: true) { () in
            
        }
    }
    
    func informSignUpFailure() {
        let alertController = UIAlertController(title: "Email already exists", message: "Use other email", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(ok)
        self.present(alertController, animated: true) { () in
        }
    }
    
}
