//
//  WallpaperCell.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 12/31/19.
//  Copyright © 2019 AudreyHa. All rights reserved.
//

import UIKit

class WallpaperCell: UICollectionViewCell {

    @IBOutlet weak var wallpaperImageView: UIImageView!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    @IBAction func downloadPressed(_ sender: Any) {
        UserDefaults.standard.set(getIndexPath()!.row, forKey: "badgeImageIndex")
        
        NotificationCenter.default.post(name: Notification.Name("saveBadgeImage"), object: nil)
    }
    
    func getIndexPath() -> IndexPath? {
        guard let superView = self.superview as? UICollectionView else {
            print("superview is not a UITableView - getIndexPath")
            return nil
        }
        var myIndexPath = superView.indexPath(for: self)
        return myIndexPath
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
