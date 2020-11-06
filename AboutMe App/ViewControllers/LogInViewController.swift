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
    
    var users = StorageManager.shared.fetchData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        StorageManager.shared.delete()
        
        for user in users {
            print("Login: \(user.login ?? "N/A")")
            print("Password: \(user.password ?? "N/A")")
            print("=================")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabBarController = segue.destination as! UITabBarController
        let welcomeVC = tabBarController.viewControllers?.first as! WelcomeViewController
        welcomeVC.welcomeText = userNameTextField.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    
    @IBAction func LogInPressed() {
        guard let userName = userNameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        for user in users {
            if userName == user.login && password == user.password {
                performSegue(withIdentifier: "logInSegue", sender: nil)
                return
            }
        }
        showWrongDataAlert(title: "Ooooops!😱",
                           message: "Your credentials are wrong")
    }
    
    @IBAction func signUpPressed() {
        showNewUserAlert(title: "Add New User",
                  message: "Enter credentials of the new user")
    }
    
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        userNameTextField.text = ""
        passwordTextField.text = ""
    }
}
    
// MARK: - Alert Controller

extension LogInViewController {
    private func showNewUserAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
        alert.addTextField { textField in
            textField.placeholder = "Enter your username"
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Enter your password"
        }
        
        let signUpAction = UIAlertAction(title: "Sign Up", style: .default) { _ in
            let login = alert.textFields?.first?.text
            let password = alert.textFields?.last?.text
            if let login = login, let password = password {
                if login.isEmpty && password.isEmpty {
                    print("Login/password is empty")
                } else {
                StorageManager.shared.save(login: login,
                                           password: password)
                self.users = StorageManager.shared.fetchData()
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(signUpAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    private func showWrongDataAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}
