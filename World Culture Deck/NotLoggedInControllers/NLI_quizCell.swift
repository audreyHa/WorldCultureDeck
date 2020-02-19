//
//  NLI_quizCell.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 2/18/20.
//  Copyright © 2020 AudreyHa. All rights reserved.
//

import UIKit

class NLI_quizCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstOption: UIButton!
    @IBOutlet weak var secondOption: UIButton!
    @IBOutlet weak var thirdOption: UIButton!
    @IBOutlet weak var questionSurrounding: UIView!
    
    var allOptionButtons=[UIButton]()

    
    override func awakeFromNib() {
        super.awakeFromNib()

        allOptionButtons=[firstOption, secondOption, thirdOption]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func option1Pressed(_ sender: Any) {
        var isFeedback=UserDefaults.standard.bool(forKey: "NLI_isFeedback")
        if(isFeedback==nil || isFeedback==false){
            UserDefaults.standard.set("A",forKey:"NLI_letter")
            buttonPressed(myButton: firstOption)
        }
    }
    
    @IBAction func option2Pressed(_ sender: Any) {
        var isFeedback=UserDefaults.standard.bool(forKey: "NLI_isFeedback")
        if(isFeedback==nil || isFeedback==false){
            UserDefaults.standard.set("B",forKey:"NLI_letter")
            buttonPressed(myButton: secondOption)
        }
    }
    
    @IBAction func option3Pressed(_ sender: Any) {
        var isFeedback=UserDefaults.standard.bool(forKey: "NLI_isFeedback")
        if(isFeedback==nil || isFeedback==false){
            UserDefaults.standard.set("C",forKey:"NLI_letter")
            buttonPressed(myButton: thirdOption)
        }
    }
    
    func buttonPressed(myButton: UIButton){
        UserDefaults.standard.set(myButton.titleLabel!.text,forKey:"NLI_newAnswer")
        var indexPath=getIndexPath()
        UserDefaults.standard.set(indexPath!.row, forKey: "NLI_newAnswerIndex")
        NotificationCenter.default.post(name: Notification.Name("newAnswerPressed"), object: nil)
    }
    
    func getIndexPath() -> IndexPath? {
        guard let superView = self.superview as? UITableView else {
            print("superview is not a UITableView - getIndexPath")
            return nil
        }
        var myIndexPath = superView.indexPath(for: self)
        return myIndexPath
    }

}
