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
    
    var allOptionButtons=[UIButton]()

    
    override func awakeFromNib() {
        super.awakeFromNib()

        allOptionButtons=[firstOption, secondOption, thirdOption]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func option1Pressed(_ sender: Any) {
        buttonPressed(myButton: firstOption)
    }
    
    @IBAction func option2Pressed(_ sender: Any) {
        buttonPressed(myButton: secondOption)
    }
    
    @IBAction func option3Pressed(_ sender: Any) {
        buttonPressed(myButton: thirdOption)
    }
    
    func buttonPressed(myButton: UIButton){
        UserDefaults.standard.set(myButton.titleLabel!.text,forKey:"newAnswer")
        var indexPath=getIndexPath()
        UserDefaults.standard.set(indexPath!.row, forKey: "newAnswerIndex")
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


