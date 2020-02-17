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
    }
    
    @IBAction func okPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
        
    }

}
