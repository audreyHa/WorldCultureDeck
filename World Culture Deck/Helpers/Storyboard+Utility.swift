//
//  Storyboard+Utility.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 12/30/19.
//  Copyright © 2019 AudreyHa. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard{
    enum WCDType: String{
        case main
        case login
        
        var filename: String{
            return rawValue.capitalized
        }
    }
    
    convenience init(type: WCDType, bundle: Bundle?=nil){
        self.init(name: type.filename, bundle: bundle)
    }
    
    static func initialViewController(for type: WCDType) -> UIViewController{
        let storyboard=UIStoryboard(type: type)
        guard let initialViewController=storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't instantiate initial view controller for \(type.filename) storyboard")
        }
        
        return initialViewController
    }
}
