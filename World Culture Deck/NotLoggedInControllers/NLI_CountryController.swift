//
//  NLI_CountryController.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 2/18/20.
//  Copyright © 2020 AudreyHa. All rights reserved.
//

import UIKit

class NLI_CountryController: UIViewController {
        @IBOutlet weak var WCDLabel: UILabel!
        @IBOutlet weak var clothingButton: UIButton!
        @IBOutlet weak var musicButton: UIButton!
        @IBOutlet weak var artButton: UIButton!
        @IBOutlet weak var foodButton: UIButton!
        @IBOutlet weak var mapImage: UIImageView!
        @IBOutlet weak var countryDescription: UILabel!
        @IBOutlet weak var blueBackground: UIView!
        @IBOutlet weak var quizButton: UIButton!
        @IBOutlet weak var linksVideoButton: UIButton!
        @IBOutlet weak var starLabel: UILabel!
        @IBOutlet weak var countryNameLabel: UILabel!
        @IBOutlet weak var xButton: UIButton!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            WCDLabel.adjustsFontSizeToFitWidth=true
            
            mapImage.layer.cornerRadius=10
            mapImage.clipsToBounds=true
            
            countryDescription.adjustsFontSizeToFitWidth=true
            
            linksVideoButton.layer.cornerRadius=10
            quizButton.layer.cornerRadius=10
            linksVideoButton.titleLabel?.adjustsFontSizeToFitWidth=true
            quizButton.titleLabel?.adjustsFontSizeToFitWidth=true

            setUpForCountry()
            
            xButton.accessibilityLabel="Close \(UserDefaults.standard.string(forKey: "NLI_countryName")!) page"
            xButton.accessibilityHint="Tap to go back to all culture cards."
            
            var myLabels=[countryNameLabel, WCDLabel, countryDescription]
            var myButtons=[clothingButton, musicButton, artButton, foodButton, quizButton, linksVideoButton]
            
            for myLabel in myLabels{
                makeLabelAccessible(myLabel: myLabel!)
            }
            
            for myButton in myButtons{
                makeButtonAccessible(myButton: myButton!)
            }
            
            mapImage.accessibilityLabel="Map of \(UserDefaults.standard.string(forKey: "NLI_countryName")!)"
            mapImage.isAccessibilityElement=true
        }
        
    func makeLabelAccessible(myLabel: UILabel){
        myLabel.adjustsFontForContentSizeCategory=true
        myLabel.adjustsFontSizeToFitWidth=true
        myLabel.font=UIFontMetrics.default.scaledFont(for: myLabel.font)
    }
    
    func makeButtonAccessible(myButton: UIButton){
        myButton.titleLabel!.adjustsFontForContentSizeCategory=true
        myButton.titleLabel!.font=UIFontMetrics.default.scaledFont(for: myButton.titleLabel!.font)
    }
    
        func setUpForCountry(){
            var countryName=UserDefaults.standard.string(forKey: "NLI_countryName")!
            countryNameLabel.text=countryName
            
            var countryMapString=countryName+"Map"
            mapImage.image=UIImage(named: countryMapString)

            let buttonsArray=[clothingButton, musicButton, artButton, foodButton]
            let images=[UIImage(named: "\(countryName)1"),UIImage(named: "\(countryName)2"),UIImage(named: "\(countryName)3"),UIImage(named: "\(countryName)4")]
            
            for i in 0...buttonsArray.count-1{
                var myButton=buttonsArray[i]
                myButton!.layer.cornerRadius=10
                myButton!.clipsToBounds=true
                myButton!.setBackgroundImage(darkenImage(originalImage: images[i]!), for: .normal)
                myButton!.adjustsImageWhenHighlighted=false
                myButton!.titleLabel?.adjustsFontSizeToFitWidth=true

            }
            
            self.countryDescription.text=returnCountryBlurb()
            
            UIGraphicsBeginImageContext(blueBackground.frame.size)
            UIImage(named: "\(countryName)Background")?.draw(in: blueBackground.bounds)
            
            if let image = UIGraphicsGetImageFromCurrentImageContext(){
                UIGraphicsEndImageContext()
                blueBackground.backgroundColor = UIColor(patternImage: image.alpha(0.2))
            }
        }
        
        func returnCountryBlurb() -> String{
            print("Running return country blurb")

            var countryName=UserDefaults.standard.string(forKey: "NLI_countryName")!
            let allBlurbs=InfoService.returnBlurbs()
            let blurb=allBlurbs[countryName]
            
            return blurb!
        }
        
        @IBAction func clothingPressed(_ sender: Any) {
            UserDefaults.standard.set("Clothing",forKey:"NLI_infoType")
            performSegue(withIdentifier: "infoController", sender: nil)
            
        }
        
        @IBAction func musicPressed(_ sender: Any) {
            UserDefaults.standard.set("Music",forKey:"NLI_infoType")
            performSegue(withIdentifier: "infoController", sender: nil)
            
        }
        
        @IBAction func artPressed(_ sender: Any) {
            UserDefaults.standard.set("Art",forKey:"NLI_infoType")
            performSegue(withIdentifier: "infoController", sender: nil)
            
        }
        
        @IBAction func foodPressed(_ sender: Any) {
            UserDefaults.standard.set("Fun Facts",forKey:"NLI_infoType")
            performSegue(withIdentifier: "infoController", sender: nil)
            
        }
        
        @IBAction func xPressed(_ sender: Any) {
            NotificationCenter.default.post(name: Notification.Name("reloadNLICultureCards"), object: nil)
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
