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
            
            let initialViewController=UIStoryboard.initialViewController(for: .login)
            self.view.window?.rootViewController=initialViewController
            self.view.window?.makeKeyAndVisible()
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
