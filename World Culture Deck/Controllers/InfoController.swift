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
        
        var countryName=UserDefaults.standard.string(forKey: "countryName")!
        UIGraphicsBeginImageContext(blueBackground.frame.size)
        UIImage(named: "\(countryName)Background")?.draw(in: blueBackground.bounds)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            blueBackground.backgroundColor = UIColor(patternImage: image.alpha(0.2))
        }
        
        numberWords=["zero","one","two","three","four","five","six"]
        setUpPage()
    }
    
    func setUpPage(){
        
        var textCategoryArray: [String:[String:String]]=[:]
        
        self.returnAllInfo{tempAllInfo in
            var countryName: String=UserDefaults.standard.string(forKey: "countryName")!
            var infoType: String=UserDefaults.standard.string(forKey: "infoType")!
            
            var countryArray: [String:Any]=tempAllInfo[countryName]! as! [String : Any]
            var countryTextArray: [String:Any]=countryArray["Text"]! as! [String : Any]
            
            textCategoryArray=countryTextArray[infoType]! as! [String : [String : String]]
            
            if(self.pageCount<=textCategoryArray.count-1){ //making sure that page count isn't exceding
                //setting the page count and header label
                self.pageCountLabel.text="\(self.pageCount+1)/\(textCategoryArray.count)"
                self.headerLabel.text="\(countryName): \(infoType)"
                
                //Setting the first and second labels
                var labels=[self.firstLabel, self.secondLabel]
                for i in 0...1{
                    var myLabel=labels[i]
                    myLabel!.text=textCategoryArray["\(self.numberWords[self.pageCount])"]!["\(self.numberWords[i])"]
                    myLabel!.adjustsFontSizeToFitWidth=true
                }
                
                var infoImageArray: [String:[String:String]]=[:]
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
            }else{
                self.pageCount-=1
            }
        }

    }
    
    @IBAction func backPressed(_ sender: Any) {
        if(pageCount>0){
            pageCount-=1
            setUpPage()
        }
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        pageCount+=1
        setUpPage()
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
