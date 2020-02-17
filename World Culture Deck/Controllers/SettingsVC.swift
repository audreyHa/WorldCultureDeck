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

    @IBOutlet weak var settingsHeader: UILabel!
    
    @IBOutlet weak var surroundingGreyView: UIView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var suggestionButton: UIButton!
    
    @IBOutlet weak var completedCountLabel: UILabel!
    @IBOutlet weak var remainingCountLabel: UILabel!
    @IBOutlet weak var quizScoreCountLabel: UILabel!
    
    @IBOutlet weak var starCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        surroundingGreyView.layer.cornerRadius=10
        logoutButton.layer.cornerRadius=10
        suggestionButton.layer.cornerRadius=10
        settingsHeader.adjustsFontSizeToFitWidth=true

        StarService.displayStars(myLabel: starCountLabel)
        updateTotals()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkNetwork()
    }
    
    //need to get deck counts
    //need to get star count, divide by 10, then divide by (decks * 3)
    
    func updateTotals(){
        self.returnUsername{username in
            self.settingsHeader.text="\(username): Settings"
        }
        
        self.returnCompletedDict{completedCountries in
            print("return completed dict")
            var allNames=["Ghana","Lebanon","Mexico","Navajo Nation","Norway","Peru","Roma","South Africa","South Korea","Tonga"]
            var incompletedNames:[String]=[]
            var completedNames:[String]=[]
            
            for countryName in allNames{
                if(completedCountries[countryName] != nil && completedCountries[countryName]==true){
                    completedNames.append(countryName)
                }else{
                    incompletedNames.append(countryName)
                }
            }
            print("Completed names: \(completedNames)")
            print("Incompleted names: \(incompletedNames)")
            
            self.completedCountLabel.text="\(completedNames.count)"
            self.remainingCountLabel.text="\(incompletedNames.count)"
            
           
            var totalQuizCorrect=Int(self.starCountLabel.text!)!/10
            self.quizScoreCountLabel.text="\(totalQuizCorrect)/\(completedNames.count*3)"
        }
    }
    
    func returnCompletedDict(completionHandler: @escaping ([String:Bool]) -> Void) {
        print("Running return completed names")
        var completedCountries: [String:Bool]=[:]
        
        let completedCountryRef=Database.database().reference().child("users").child(User.current.uid).child("Completed Countries")
        
        completedCountryRef.observeSingleEvent(of: .value, with: { (snapshot) in
                completedCountries=snapshot.value as! [String:Bool]
                completionHandler(completedCountries)
        })
    }
    
    func returnUsername(completionHandler: @escaping (String) -> Void) {
        print("Running return username")
        
        let usernameRef=Database.database().reference().child("users").child(User.current.uid).child("username")
        
        usernameRef.observeSingleEvent(of: .value, with: { (snapshot) in
                let username=snapshot.value as! String
                completionHandler(username)
        })
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
