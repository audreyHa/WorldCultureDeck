//
//  CreateUsernameViewController.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 12/30/19.
//  Copyright © 2019 AudreyHa. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController {
    
    @IBOutlet weak var createUsernameLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius=10
        createUsernameLabel.adjustsFontSizeToFitWidth=true
    }

    override func viewDidAppear(_ animated: Bool) {
        checkNetwork()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton){
        //1 check that a FIRUser is logged in and that user has provided a username in text field
        print("next button tapped")
        
        guard let firUser=Auth.auth().currentUser,
            let username=usernameTextField.text,
            !username.isEmpty else {return}
        
        UserService.create(firUser, username: username){(user) in
            guard let user=user else {return}
            
            User.setCurrent(user, writeToUserDefaults: true)
            
            let storyboard = UIStoryboard(name: "Main", bundle: .main)

            let initialViewController=UIStoryboard.initialViewController(for: .main)
            self.view.window?.rootViewController=initialViewController
            self.view.window?.makeKeyAndVisible()
        }
    }

}
