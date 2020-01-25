//
//  QuizCell.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 1/24/20.
//  Copyright © 2020 AudreyHa. All rights reserved.
//

import UIKit

class QuizCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstOption: UIButton!
    @IBOutlet weak var secondOption: UIButton!
    @IBOutlet weak var thirdOption: UIButton!
    @IBOutlet weak var questionSurrounding: UIView!
    
    var mintColor: UIColor=UIColor(red: 215.0/255.0, green: 241.0/255.0, blue: 227.0/255.0, alpha: 1.0)
    var tealColor: UIColor=UIColor(red: 8.0/255.0, green: 164.0/255.0, blue: 157.0/255.0, alpha: 1.0)
    var allOptionButtons=[UIButton]()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        allOptionButtons=[firstOption, secondOption, thirdOption]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func option1Pressed(_ sender: Any) {
        setButtonSelected(myButton: firstOption)
    }
    
    @IBAction func option2Pressed(_ sender: Any) {
        setButtonSelected(myButton: secondOption)
    }
    
    @IBAction func option3Pressed(_ sender: Any) {
        setButtonSelected(myButton: thirdOption)
    }
    
    func setButtonSelected(myButton: UIButton){
        if(myButton.backgroundColor==mintColor){
            myButton.backgroundColor=tealColor
            myButton.setTitleColor(mintColor, for: .normal)
        }else{
            myButton.backgroundColor=mintColor
            myButton.setTitleColor(tealColor, for: .normal)
        }
        
        for button in allOptionButtons{
            if(button != myButton){
                button.backgroundColor=tealColor
                button.setTitleColor(mintColor, for: .normal)
            }
        }
    }
}

