//
//  StarService.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 2/1/20.
//  Copyright © 2020 AudreyHa. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct StarService{
    
    static func displayStars(myLabel: UILabel){
        let currentUID=User.current.uid
        
        let starCountRef=Database.database().reference().child("users").child(currentUID).child("stars")
        var starCount="0"
        
        starCountRef.observe( .value, with: { (snapshot) in
          // Get user value
          starCount = snapshot.value as? String ?? "0" //just set variable currentScore to 0 if that quiz has never been taken before
            print("star count \(starCount)")
            myLabel.text = "\(starCount)"
        })
        
    }
}
