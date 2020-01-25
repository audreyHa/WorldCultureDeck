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
    @IBOutlet weak var quizButton: UIButton!
    @IBOutlet weak var linksVideoButton: UIButton!
    
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
            myButton!.setBackgroundImage(darkenImage(originalImage: images[i]!), for: .normal)
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
        
        linksVideoButton.layer.cornerRadius=10
        quizButton.layer.cornerRadius=10
        linksVideoButton.titleLabel?.adjustsFontSizeToFitWidth=true
        quizButton.titleLabel?.adjustsFontSizeToFitWidth=true
        
    }
    
    @IBAction func clothingPressed(_ sender: Any) {
        UserDefaults.standard.set("South Korea",forKey:"countryName")
        UserDefaults.standard.set("Clothing",forKey:"infoType")
        performSegue(withIdentifier: "infoController", sender: nil)
        
    }
    
    @IBAction func musicPressed(_ sender: Any) {
        UserDefaults.standard.set("South Korea",forKey:"countryName")
        UserDefaults.standard.set("Music",forKey:"infoType")
        performSegue(withIdentifier: "infoController", sender: nil)
        
    }
    
    @IBAction func artPressed(_ sender: Any) {
        UserDefaults.standard.set("South Korea",forKey:"countryName")
        UserDefaults.standard.set("Art",forKey:"infoType")
        performSegue(withIdentifier: "infoController", sender: nil)
        
    }
    
    @IBAction func foodPressed(_ sender: Any) {
        UserDefaults.standard.set("South Korea",forKey:"countryName")
        UserDefaults.standard.set("Food",forKey:"infoType")
        performSegue(withIdentifier: "infoController", sender: nil)
        
    }
    
    @IBAction func xPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func quizPressed(_ sender: Any) {
        performSegue(withIdentifier: "quizController", sender: nil)
    }
    
    func darkenImage(originalImage: UIImage) -> UIImage{
        // Get the original image and set up the CIExposureAdjust filter
        guard let inputImage = CIImage(image: originalImage),
          let filter = CIFilter(name: "CIExposureAdjust") else { return originalImage}

        // The inputEV value on the CIFilter adjusts exposure (negative values darken, positive values brighten)
        filter.setValue(inputImage, forKey: "inputImage")
        filter.setValue(-2.0, forKey: "inputEV")

        // Break early if the filter was not a success (.outputImage is optional in Swift)
        guard let filteredImage = filter.outputImage else { return originalImage}

        let context = CIContext(options: nil)
        let outputImage = UIImage(cgImage: context.createCGImage(filteredImage, from: filteredImage.extent)!)
        
        return outputImage
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
