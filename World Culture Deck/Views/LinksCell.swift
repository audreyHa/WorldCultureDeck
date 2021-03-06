//
//  LinksCell.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 2/16/20.
//  Copyright © 2020 AudreyHa. All rights reserved.
//

import UIKit

class LinksCell: UITableViewCell {

    @IBOutlet weak var websiteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        guard let customFont = UIFont(name: "Montserrat-SemiBold", size: UIFont.labelFontSize) else {
            fatalError("""
                Failed to load the "Montserrat" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }

        websiteLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: customFont)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
