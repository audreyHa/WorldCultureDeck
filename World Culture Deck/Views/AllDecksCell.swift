//
//  AllDecksCell.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 12/31/19.
//  Copyright © 2019 AudreyHa. All rights reserved.
//

import UIKit

class AllDecksCell: UICollectionViewCell {
    
    @IBOutlet weak var regionImage: UIImageView!
    @IBOutlet weak var regionLabel: UILabel!

    override func awakeFromNib() {
        guard let customFont = UIFont(name: "Montserrat-SemiBold", size: UIFont.labelFontSize) else {
            fatalError("""
                Failed to load the "Montserrat" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        
        regionLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: customFont)
    }
}
