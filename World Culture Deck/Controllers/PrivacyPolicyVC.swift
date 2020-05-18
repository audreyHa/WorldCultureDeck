//
//  PrivacyPolicyVC.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 2/19/20.
//  Copyright © 2020 AudreyHa. All rights reserved.
//

import UIKit

class PrivacyPolicyVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var wcdImage: UIImageView!
    @IBOutlet weak var wholeAlertView: UIView!
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var bigHeader: UILabel!
    @IBOutlet weak var bigTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var myLabels=[bigHeader]
        var myButtons=[okButton]
        
        for myLabel in myLabels{
            makeLabelAccessible(myLabel: myLabel!)
        }
        
        for myButton in myButtons{
            makeButtonAccessible(myButton: myButton!)
        }
        
        bigHeader.text="Privacy Policy!"
        okButton.setTitle("  Continue  ", for: .normal)
        
        bigTextView.font=UIFontMetrics.default.scaledFont(for: bigTextView.font!)
        bigTextView.adjustsFontForContentSizeCategory=true
        
        topView.layer.cornerRadius = 10
        topView.clipsToBounds = true
        
        bottomView.layer.cornerRadius = 10
        bottomView.clipsToBounds = true
        
        okButton.layer.cornerRadius = 5
        okButton.clipsToBounds = true
        
        centerView.superview?.bringSubviewToFront(centerView)
        
        wcdImage.superview?.bringSubviewToFront(wcdImage)
        
        bigTextView.layer.cornerRadius=10
        
        bigTextView.text="By clicking continue or continuing to use this app, you acknowledge that:\n\nWorld Culture Deck incorporates Firebase Authentication for signing users in, Firebase Realtime Database for storing user data, and Firebase Analytics: an analytics service provided by Google LLC. In order to understand Google's use of Data, see Google's policy on “How Google uses data when you use our partners' sites or apps.”\n\nFirebase Analytics may share Data with other tools provided by Firebase, such as Crash Reporting, Authentication, Remote Config or Notifications.\n\nPersonal Data collected by World Culture Deck through Firebase:\n\u{2022}Email and username\n\u{2022}Quiz scores, total badges earned, total stars earned\n\u{2022}Geography/region\n\u{2022}Number of users\n\u{2022}Number of sessions\n\u{2022}Session duration\n\u{2022}iPhone type\n\u{2022}Application opens\n\u{2022}Application updates\n\u{2022}First launches \n\u{2022}Frequency of app crashes\n\nThe only purpose of World Culture Deck collecting user behavior data for this version is to improve user experience and guide development for the next release. If you do not wish to participate and help the app (and me) better understand your needs, you are always welcome to come back and install a later version.\n\nIf you have any questions, please feel free to contact me at dayhighlightsapp@gmail.com!"
        
        let linkedText = NSMutableAttributedString(attributedString: bigTextView.attributedText!)
        let hyperlinked = linkedText.setAsLink(textToFind: "How Google uses data when you use our partners' sites or apps.", linkURL: "https://policies.google.com/technologies/partner-sites",secondText:"dayhighlightsapp@gmail.com",secondURL:"mailto:dayhighlightsapp@gmail.com")
        
        if hyperlinked {
            bigTextView.attributedText! = NSAttributedString(attributedString: linkedText)
        }
    }
    
    func makeLabelAccessible(myLabel: UILabel){
        myLabel.adjustsFontForContentSizeCategory=true
        myLabel.adjustsFontSizeToFitWidth=true
        myLabel.font=UIFontMetrics.default.scaledFont(for: myLabel.font)
    }
    
    func makeButtonAccessible(myButton: UIButton){
        myButton.titleLabel!.adjustsFontForContentSizeCategory=true
        myButton.titleLabel!.adjustsFontSizeToFitWidth=true
        myButton.titleLabel!.font=UIFontMetrics.default.scaledFont(for: myButton.titleLabel!.font)
    }
    
    @IBAction func okPressed(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "privacyPolicy")
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
        
    }

}

extension NSMutableAttributedString {
    public func setAsLink(textToFind:String, linkURL:String, secondText: String, secondURL: String) -> Bool {
        
        let foundRange = self.mutableString.range(of: textToFind)
        let secondRange=self.mutableString.range(of: secondText)
        if (foundRange.location != NSNotFound) && (secondRange.location != NSNotFound){
            
            self.addAttribute(.link, value: linkURL, range: foundRange)
            self.addAttribute(.link, value: secondURL, range: secondRange)
            
            let multipleAttributes: [NSAttributedString.Key : Any] = [
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            
            self.addAttributes(multipleAttributes, range: foundRange)
            
            return true
        }
        return false
    }
}
