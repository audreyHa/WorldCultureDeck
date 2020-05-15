//
//  ShortAlertVC.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 2/17/20.
//  Copyright © 2020 AudreyHa. All rights reserved.
//

import UIKit

class ShortAlertVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var wcdImage: UIImageView!
    @IBOutlet weak var wholeAlertView: UIView!
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var bigHeader: UILabel!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bigHeader.adjustsFontSizeToFitWidth = true
        label.adjustsFontSizeToFitWidth = true
        okButton.setTitle("  Ok  ", for: .normal)
        okButton.titleLabel!.adjustsFontSizeToFitWidth = true
        
        switch (UserDefaults.standard.string(forKey: "typeShortAlert")) {
        case "internet":
            bigHeader.text="ALERT!"
            label.text="You need Wi-Fi/Internet to access lessons!"
            okButton.setTitle("  Ok  ", for: .normal)
        case "logIn":
            bigHeader.text="ALERT!"
            label.text="You need Wi-Fi/Internet to log in!"
            okButton.setTitle("  Ok  ", for: .normal)
        case "needToUnlock":
            bigHeader.text="ALERT!"
            label.text="You need more stars to unlock this badge!"
            okButton.setTitle("  Ok  ", for: .normal)
        case "errorSaving":
            bigHeader.text="ALERT!"
            label.text="Error saving badge image!"
            okButton.setTitle("  Ok  ", for: .normal)
        case "savedSuccess":
            bigHeader.text="Success!"
            label.text="Successfuly saved badge image to Photo Library!"
            okButton.setTitle("  Ok  ", for: .normal)
        default:
            print("Error! Could not react to short alert!")
        }
        
        topView.layer.cornerRadius = 10
        topView.clipsToBounds = true
        
        bottomView.layer.cornerRadius = 10
        bottomView.clipsToBounds = true
        
        okButton.layer.cornerRadius = 5
        okButton.clipsToBounds = true
        
        centerView.superview?.bringSubviewToFront(centerView)
        
        wcdImage.superview?.bringSubviewToFront(wcdImage)
        
        makeLabelAccessible(myLabel: bigHeader)
        makeLabelAccessible(myLabel: label)
        makeButtonAccessible(myButton: okButton)
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
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
        
    }

}
