//
//  SettingsVC.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 12/30/19.
//  Copyright © 2019 AudreyHa. All rights reserved.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {

    @IBOutlet weak var surroundingGreyView: UIView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var suggestionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        surroundingGreyView.layer.cornerRadius=10
        logoutButton.layer.cornerRadius=10
        suggestionButton.layer.cornerRadius=10
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            
            guard let window = self.view.window else {
                return
            }
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Login")

            // Set the new rootViewController of the window.
            // Calling "UIView.transition" below will animate the swap.
            window.rootViewController = vc

            // A mask of options indicating how you want to perform the animations.
            let options: UIView.AnimationOptions = .transitionCrossDissolve

            // The duration of the transition animation, measured in seconds.
            let duration: TimeInterval = 0.3

            // Creates a transition animation.
            // Though `animations` is optional, the documentation tells us that it must not be nil. ¯\_(ツ)_/¯
            UIView.transition(with: window, duration: duration, options: options, animations: {}, completion:
            { completed in
                // maybe do something on completion here
            })
        }catch let error as NSError{
            assertionFailure("Error signing out: \(error.localizedDescription)")
        }
    }
    
    @IBAction func suggestionPressed(_ sender: Any) {
        let subject="Suggestion About World Culture Deck"
        let address="dayhighlightsapp@gmail.com"
        let buildInfo=""
        let googleUrlString = "googlegmail:///co?to=\(address.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? "")&subject=\(subject.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? "")&body=\(buildInfo.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? "")"

        if let googleUrl = URL(string: googleUrlString) {
            UIApplication.shared.open(googleUrl, options: [:]) {
                success in
                if !success {
                     // Notify user or handle failure as appropriate
                    print("no success opening email")
                }
            }
        }
    }
    
}
