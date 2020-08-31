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
    
    let registeredUser = UserInfo()
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabBarController = segue.destination as! UITabBarController
        let welcomeVC = tabBarController.viewControllers?.first as! WelcomeViewController
        welcomeVC.welcomeText = userNameTextField.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    
    @IBAction func logginIn() {
        guard let username = userNameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if registeredUser.login == username && registeredUser.password == password  {
            performSegue(withIdentifier: "logInSegue", sender: nil)
        } else {
            showAlert(title: "Oooooops!😱", message: "Your login or password is wrong")
            passwordTextField.text = ""
        }
    }
    
    @IBAction func remindButtons(_ sender: UIButton) {
        if sender.title(for: .normal) == "Forgot UserName?" {
            showAlert(title: "Don't Worry!😎", message: "Your login is \(registeredUser.login)")
        } else {
            showAlert(title: "It's OK🤗", message: "Your login is \(registeredUser.password)")
        }
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        userNameTextField.text = ""
        passwordTextField.text = ""
    }
}
    
// MARK: - Alert Controller

extension LogInViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Thanks!", style: .default)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
}
