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

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageCountLabel: UILabel!
    @IBOutlet weak var blueBackground: UIView!
    @IBOutlet weak var starLabel: UILabel!
    
    var pageCount: Int=0
    var numberWords: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.layer.cornerRadius=10
        nextButton.layer.cornerRadius=10
        
        StarService.displayStars(myLabel: starLabel)
        
        UIGraphicsBeginImageContext(blueBackground.frame.size)
        UIImage(named: "southKoPalace.jpg")?.draw(in: blueBackground.bounds)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            blueBackground.backgroundColor = UIColor(patternImage: image.alpha(0.2))
        }
        
        numberWords=["zero","one","two","three","four","five","six"]
        setUpPage()
        setPageNumber()
    }
    
    func setUpPage(){
        
        var textCategoryArray: [String:[String:String]]=[:]
        
        self.returnAllInfo{tempAllInfo in
            var countryName: String=UserDefaults.standard.string(forKey: "countryName")!
            var infoType: String=UserDefaults.standard.string(forKey: "infoType")!
            var countryArray: [String:Any]=tempAllInfo[countryName]! as! [String : Any]
            var countryTextArray: [String:Any]=countryArray["Text"]! as! [String : Any]
            textCategoryArray=countryTextArray[infoType]! as! [String : [String : String]]
            
            //setting the header label
            self.headerLabel.text="\(countryName): \(infoType)"
            
            //Setting the first and second labels
            var labels=[self.firstLabel, self.secondLabel]
            for i in 0...1{
                var myLabel=labels[i]
                myLabel!.text=textCategoryArray["\(self.numberWords[self.pageCount])"]!["\(self.numberWords[i])"]
                myLabel!.adjustsFontSizeToFitWidth=true
            }
        }
        
        var infoImageArray: [String:[String:String]]=[:]
        
        self.returnAllInfo{tempAllInfo in
            var countryName: String=UserDefaults.standard.string(forKey: "countryName")!
            var infoType: String=UserDefaults.standard.string(forKey: "infoType")!
            var countryArray: [String:Any]=tempAllInfo[countryName]! as! [String : Any]
            var countryImageNameArray: [String:Any]=countryArray["ImageNames"]! as! [String : Any]
            infoImageArray=countryImageNameArray[infoType]! as! [String : [String : String]]
            
            //setting the first and second images
            var imageViews=[self.firstImage, self.secondImage]
            self.firstImage.image=nil
            self.secondImage.image=nil
            for i in 0...1{
                var myImageView=imageViews[i]
                var imageName=infoImageArray["\(self.numberWords[self.pageCount])"]!["\(self.numberWords[i])"]
                
                if(imageName != ""){
                    myImageView!.image=UIImage(named: imageName!)?.roundedImage
                }
            }
        }
        
    }
    
    func setPageNumber(){
        var textCategoryArray: [String:[String:String]]=[:]
        
        self.returnAllInfo{tempAllInfo in
            var countryName: String=UserDefaults.standard.string(forKey: "countryName")!
            var infoType: String=UserDefaults.standard.string(forKey: "infoType")!
            var countryArray: [String:Any]=tempAllInfo[countryName]! as! [String : Any]
            var countryTextArray: [String:Any]=countryArray["Text"]! as! [String : Any]
            textCategoryArray=countryTextArray[infoType]! as! [String : [String : String]]
            
            self.pageCountLabel.text="\(self.pageCount+1)/\(textCategoryArray.count)"
        }
    }
    
    @IBAction func backPressed(_ sender: Any) {
        if(pageCount>0){
            pageCount-=1
            setPageNumber()
            setUpPage()
        }
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        var textCategoryArray: [String:[String:String]]=[:]
        
        self.returnAllInfo{tempAllInfo in
            var countryName: String=UserDefaults.standard.string(forKey: "countryName")!
            var infoType: String=UserDefaults.standard.string(forKey: "infoType")!
            var countryArray: [String:Any]=tempAllInfo[countryName]! as! [String : Any]
            var countryTextArray: [String:Any]=countryArray["Text"]! as! [String : Any]
            textCategoryArray=countryTextArray[infoType]! as! [String : [String : String]]
            
            //check to make sure you're not increasing page count beyond limit
            if(self.pageCount<textCategoryArray.count-1){
                self.pageCount+=1
                self.setPageNumber()
                self.setUpPage()
            }
        }
    }

    @IBAction func xPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func returnAllInfo(completionHandler: @escaping ([String:Any]) -> Void) {
        print("Running return all info")
        var tempAllInfo: [String:Any]=[:]
        
        let allCountriesRef=Database.database().reference().child("countryInfo")
        
        allCountriesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! NSDictionary
            tempAllInfo=value as! [String:Any]
            completionHandler(tempAllInfo)
        })
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
