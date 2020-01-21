//
//  CountryController.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 1/20/20.
//  Copyright © 2020 AudreyHa. All rights reserved.
//

import UIKit
import Kingfisher

class CountryController: UIViewController {

    @IBOutlet weak var clothingButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var artButton: UIButton!
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var mapImage: UIImageView!
    @IBOutlet weak var countryDescription: UILabel!
    @IBOutlet weak var blueBackground: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapImage.image=UIImage(named: "koreaMap")
        mapImage.layer.cornerRadius=10
        mapImage.clipsToBounds=true
        
        let buttonsArray=[clothingButton, musicButton, artButton, foodButton]
        let images=[UIImage(named: "korea1"),UIImage(named: "korea2"),UIImage(named: "korea3"),UIImage(named: "korea4")]
        
        for i in 0...buttonsArray.count-1{
            var myButton=buttonsArray[i]
            myButton!.layer.cornerRadius=10
            myButton!.clipsToBounds=true
            myButton!.setBackgroundImage(images[i]!.alpha(0.8), for: .normal)
            myButton!.adjustsImageWhenHighlighted=false

        }
        
        countryDescription.text="South Korea is a country in East Asia. Major cities include Seoul (capital) and Busan"
        countryDescription.adjustsFontSizeToFitWidth=true
        
        UIGraphicsBeginImageContext(blueBackground.frame.size)
        UIImage(named: "southKoPalace.jpg")?.draw(in: blueBackground.bounds)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            blueBackground.backgroundColor = UIColor(patternImage: image.alpha(0.2))
        }
        
    }
    
}

extension UIImage {

    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
