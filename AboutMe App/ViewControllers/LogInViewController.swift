//
//  ViewController.swift
//  AboutMe App
//
//  Created by Yaroslav on 29.08.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabBarController = segue.destination as! UITabBarController
        let welcomeVC = tabBarController.viewControllers?.first as! WelcomeViewController
        welcomeVC.welcomeText = "Welcome, \(userNameTextField.text!)!"
    }
    
    
    @IBAction func logginIn() {
        let registeredUser = UserInfo()
        
        guard let username = userNameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if registeredUser.login == username && registeredUser.password == password  {
            performSegue(withIdentifier: "logInSegue", sender: nil)
        } else {
            let alertController = UIAlertController(title: "Oooooops!😱",
                                                    message: "Your login or password is wrong",
                                                    preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Try again", style: .default)
            alertController.addAction(action)
            self.present(alertController, animated: true)
            
        }
    }
    
    
    @IBAction func remindButtons(_ sender: UIButton) {
        let registeredUser = UserInfo()
        if sender.title(for: .normal) == "Forgot UserName?" {
            let alertController = UIAlertController(title: "Don't worry!😎",
                                                    message: "Your login is \(registeredUser.login)",
                                                    preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Thanks!", style: .default)
            alertController.addAction(action)
            self.present(alertController, animated: true)
        } else {
            let alertController = UIAlertController(title: "It's OK🤗",
                                                    message: "Your login is \(registeredUser.password)",
                                                    preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Thanks!", style: .default)
            alertController.addAction(action)
            self.present(alertController, animated: true)
        }
    }
    

    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        userNameTextField.text = ""
        passwordTextField.text = ""
    }
}