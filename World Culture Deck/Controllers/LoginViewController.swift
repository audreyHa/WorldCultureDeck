//
//  LoginViewController.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 12/30/19.
//  Copyright © 2019 AudreyHa. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase

typealias FIRUser=FirebaseAuth.User

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var WCDLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var orLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var myButtons=[loginButton, continueButton]
        var myLabels=[WCDLabel, orLabel]
        
        for myButton in myButtons{
            makeButtonAccessible(myButton: myButton!)
        }
        
        for myLabel in myLabels{
            makeLabelAccessible(myLabel: myLabel!)
        }
        
        var privacyPolicy=UserDefaults.standard.bool(forKey: "privacyPolicy")
        
        if(privacyPolicy==nil || privacyPolicy==false){
            makePrivacyPolicy()
        }
    }
    
    func makeLabelAccessible(myLabel: UILabel){
        myLabel.adjustsFontForContentSizeCategory=true
        myLabel.adjustsFontSizeToFitWidth=true
        myLabel.font=UIFontMetrics.default.scaledFont(for: myLabel.font)
    }
    
    func makeButtonAccessible(myButton: UIButton){
        myButton.layer.cornerRadius=10
        myButton.titleLabel!.adjustsFontForContentSizeCategory=true
        myButton.titleLabel!.adjustsFontSizeToFitWidth=true
        myButton.titleLabel!.font=UIFontMetrics.default.scaledFont(for: myButton.titleLabel!.font)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        logIn()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let authUI=FUIAuth.defaultAuthUI() else {return}
        
        authUI.delegate=self
        
        let authViewController=authUI.authViewController()
        present(authViewController, animated: true)
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        
    }
    
}


extension LoginViewController: FUIAuthDelegate{
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?){
        if let error=error{
            assertionFailure("Error in signing in: \(error.localizedDescription)")
            return
        }
        
        //1 Check that FIRUser return from authentication is not nil
        guard let user=authDataResult?.user else {return}
        
        //2 Construct relative path to the reference of the user's info in our JSON database
        let userRef=Database.database().reference().child("users").child(user.uid)
        
        //3 Read from path we created and pass an event closure to handle data (snapshot) that is passed back from the database
        UserService.show(forUID: user.uid){(user) in
            //1
            if let user=user{
                User.setCurrent(user, writeToUserDefaults: true)
                
                let initialViewController=UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController=initialViewController
                self.view.window?.makeKeyAndVisible()
            }else{
                self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
            }
        }
    }

}
