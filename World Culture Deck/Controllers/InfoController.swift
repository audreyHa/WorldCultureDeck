//
//  InfoController.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 1/20/20.
//  Copyright © 2020 AudreyHa. All rights reserved.
//

import UIKit
import FirebaseDatabase

class InfoController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageCountLabel: UILabel!
    @IBOutlet weak var blueBackground: UIView!
    @IBOutlet weak var starLabel: UILabel!
    
    var pageCount: Int=0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.layer.cornerRadius=10
        nextButton.layer.cornerRadius=10
        slider.isEnabled=false
        
        StarService.displayStars(myLabel: starLabel)
        
        UIGraphicsBeginImageContext(blueBackground.frame.size)
        UIImage(named: "southKoPalace.jpg")?.draw(in: blueBackground.bounds)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            blueBackground.backgroundColor = UIColor(patternImage: image.alpha(0.2))
        }
        
        setUpPage()
        setSlider()
    }
    
    func setUpPage(){
        var countryName: String=UserDefaults.standard.string(forKey: "countryName")!
        var infoType: String=UserDefaults.standard.string(forKey: "infoType")!
        var infoDict=returnTextCategoryDict()
        var imageDict=returnImageNameDict()
        
        headerLabel.text="\(countryName): \(infoType)"
        
        var labels=[firstLabel, secondLabel]
        for i in 0...1{
            var myLabel=labels[i]
            myLabel!.text=infoDict["\(pageCount)"]!["\(i)"]
            myLabel!.adjustsFontSizeToFitWidth=true
        }
        
        var imageViews=[firstImage, secondImage]
        firstImage.image=nil
        secondImage.image=nil
        for i in 0...1{
            var myImageView=imageViews[i]
            var imageName=imageDict["\(pageCount)"]!["\(i)"]
            
            if(imageName != ""){
                myImageView!.image=UIImage(named: imageName!)?.roundedImage
            }
        }
    }
    
    func setSlider(){
        var infoDict=returnTextCategoryDict()
        slider.minimumValue=0
        slider.maximumValue=Float(infoDict.count-1)
        slider.setValue(Float(pageCount), animated: true)
        pageCountLabel.text="\(pageCount+1)/\(infoDict.count)"
    }
    
    func returnAllInfo(completionHandler: @escaping ([String:[String:[String:[String:[String:String]]]]]) -> Void) {
        var tempAllInfo: [String:[String:[String:[String:[String:String]]]]]=[:]
        
        let allCountriesRef=Database.database().reference().child("countryInfo")
        
        allCountriesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            print("doing this")
            tempAllInfo = (snapshot.value as? [String:[String:[String:[String:[String:String]]]]])!
            completionHandler(tempAllInfo)
        })
    }
    
    func returnTextCategoryDict() -> [String:[String:String]]{
        var textCategoryArray: [String:[String:String]]=[:]
        
        self.returnAllInfo{tempAllInfo in
            var countryName: String=UserDefaults.standard.string(forKey: "countryName")!
            var infoType: String=UserDefaults.standard.string(forKey: "infoType")!
            var countryTextArray: [String:[String:[String:String]]]=tempAllInfo[countryName]!["Text"]!
            textCategoryArray=countryTextArray[infoType]!
            
        }

        return textCategoryArray
    }
    
    func returnImageNameDict() -> [String:[String:String]]{
        var infoImageArray: [String:[String:String]]=[:]
        
        self.returnAllInfo{tempAllInfo in
            var countryName: String=UserDefaults.standard.string(forKey: "countryName")!
            var infoType: String=UserDefaults.standard.string(forKey: "infoType")!
            var countryImageNameArray: [String:[String:[String:String]]]=tempAllInfo[countryName]!["ImageNames"]!
            infoImageArray=countryImageNameArray[infoType]!
            
        }

        return infoImageArray
    }
    
    @IBAction func backPressed(_ sender: Any) {
        if(pageCount>0){
            pageCount-=1
            setSlider()
            setUpPage()
        }
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        var infoDict=returnTextCategoryDict()
        if(pageCount<infoDict.count-1){
            pageCount+=1
            setSlider()
            setUpPage()
        }
    }

    
    @IBAction func xPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}

extension UIImage{
    var roundedImage: UIImage {
        let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
        UIBezierPath(
            roundedRect: rect,
            cornerRadius: self.size.height
            ).addClip()
        self.draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}
