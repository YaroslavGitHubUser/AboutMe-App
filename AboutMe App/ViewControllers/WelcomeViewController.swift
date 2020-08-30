//
//  WelcomeViewController.swift
//  AboutMe App
//
//  Created by Yaroslav on 29.08.2020.
//  Copyright © 2020 Yaroslav. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet var welcomeLabel: UILabel!
    
    var welcomeText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLabel.text = welcomeText
    }

    @IBAction func logOutButton() {
        dismiss(animated: true)
    }
}
