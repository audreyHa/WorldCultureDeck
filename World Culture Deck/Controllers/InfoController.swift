//
//  InfoController.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 1/20/20.
//  Copyright © 2020 AudreyHa. All rights reserved.
//

import UIKit

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
    
    var pageCount: Int=0
    
    var allCountryInfo: [String: [[String:[[String]]]]]=[
        "South Korea":[["Clothing":[["The Hanbok is the traditional Korean dress.",
                             "Most of today’s Hanboks follow the style of the Joseon Dynasty (1392-1897), but Hanboks existed as early as 1600 years ago."],
                             ["For men, a full Hanbok has a vest and pants.",
                              "For women, the full Hanbok has a fitted top jacket, undershirt, and a wide, flexible skirt. Hanboks for women resemble a bell shape."],
                             ["Currently, the Hanbok is only worn for special occasions or Korean holidays.",
                             "Children wear the Hanbok for their 1st birthday and adults wear it for their wedding or major family events like funerals."],
                             ["Hanboks are made using natural dyes, giving the dress more vibrant and deep colors compared to artificial dyes. ",
                              "Hair accessories, including hairpins or headbands, are often worn with the Hanbok."]],
                 "Music":[["BTS is one of the most famous K-pop (Korean pop) groups. The band is made up of seven Korean singers: Jin, Suga, J-Hope, RM, Jimin, V, and Jungkook.",
                 "BTS has hit #1 on iTunes in more than 65 countries, and they’re the first K-pop group to top U.S. music album charts. BTS’s “Boy With Luv” Youtube video was the fastest Youtube video to ever hit 100 million views."],
                          
                          ["BTS’s songs include topics like bullying and mental health, which other bands may not cover.",
                            "Some of the key factors of BTS’s success are their impressives dance routines, creative music videos, and the topics in their songs."],
                          
                          ["Gugak, which directly translates to “national music,” refers to traditional Korean music, songs, dances, and ceremonial performances.",
                           "Buchaechum is the Korean fan dance, usually performed by female dancers holding fans with floral prints."],
                          
                          ["Of all Korean folk songs, Arirang is the most famous and important among Koreans.",
                           "Different regional and local communities have their own musical and lyrical variations of the song, showcasing the cultural diversity of Korea. The song is renowned for its beautiful, heart-rending melody."],
                          ["One of the most prominent Korean traditional instruments is the Daegeum flute. It’s a large, 31-inch transverse flute, traditionally used in court and folk music.",
                           "The Daegeum is made of bamboo and has a buzzing membrane that creates a distinct sound. It’s also used for modern classical music and movie scores."]],
                 "Art":[["Calligraphy developed in Korea through cultural influences from China.",
                         "Calligraphy is the art of handwriting using ink and brush strokes. One of the most famous Korean calligraphers is Kim Jeong-hui, who developed his own style of calligraphy called “Chusa Style.”"],
                        
                        ["Paintings during the early Joseon dynasty (1400s) were similar to the Chinese style of peaceful landscapes",
                         "In the later Joseon dynasty, paintings transitioned towards realism. In the 1700s, one of the great Korean artists was Kim Hong-do who often illustrated the day-to-day activities of ordinary people. Directly above is Ssireum, one of Kim Hong-do’s paintings, illustrating Korean wrestlers along with their spectators."],
                        ["Korean pottery usually falls into 3 categories: Cheongja (blue-green celadon), Buncheong (stoneware), and Baekja (white porcelain).",
                         "Celadon blue-green pottery was mostly made during the Goryeo Dynasty (918-1392). "],["Buncheong was made by Goryeo potters after the end of the Goryeo Dynasty in 1392. This type of stone pottery has simple designs on the outside.","The white porcelain pottery was mainly from the Joseon Dynasty (1392-1910). The porcelain was typically covered with designs made with iron, copper, and cobalt."]],
                 "Food":[["Kimchi is arguably the most classic of all Korean foods.",
                          "It is spicy, salty, and fermented cabbage mixed with some pepper, garlic, ginger, or scallion. At every restaurant and meal, Kimchi is usually available at the table."],
                         ["Bulgogi is a common sweet meat that’s been in Korea for thousands of years.",
                          "Galbi or Korean barbeque is thick meat marinated in a soy sauce, garlic, and sugar mixture. Galbi is grilled over a fire and is a staple of Korean culture."],
                         ["Bibimpap is a mixed bowl with rice, vegetables, rice, beef, egg, sesame oil, and chili paste for flavor.",
                          "Gimbap is a popular meal and street food. Vegetables, meat, eggs, and rice are rolled together in seaweed and then cut into bite sized circular pieces."]]
                ], //end of text
               ["Clothing":[
                        ["koClothing1","koClothing2"],
                        ["koClothing6","koClothing5"],
                        ["koClothing3","koClothing4"],
                        ["koClothing7",""]],
                "Music":[
                    ["koMusicA","koMusicB"],
                    ["koMusicC","koMusicD"],
                    ["koMusic1","koMusic2"],
                    ["koMusic3","koMusic4"],
                    ["koMusic5","koMusic6"]],
                "Art":[
                    ["koArt1","koArt2"],
                    ["koArt3","koArt4"],
                    ["koArt5","koArt6"],
                    ["koArt7","koArt8"]],
                "Food":[
                    ["koFood1","koFood2"],
                    ["koFood3","koFood4"],
                    ["koFood5","koFood6"]]
            ]
        ] //end of South Korea
    ] //end of Array
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.layer.cornerRadius=10
        nextButton.layer.cornerRadius=10
        slider.isEnabled=false
        
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
        var infoArray=returnInfoArray()
        var imageArray=returnImageArray()
        
        headerLabel.text="\(countryName): \(infoType)"
        
        var labels=[firstLabel, secondLabel]
        for i in 0...1{
            var myLabel=labels[i]
            myLabel!.text=infoArray[pageCount][i]
            myLabel!.adjustsFontSizeToFitWidth=true
        }
        
        var imageViews=[firstImage, secondImage]
        firstImage.image=nil
        secondImage.image=nil
        for i in 0...1{
            var myImageView=imageViews[i]
            var imageName=imageArray[pageCount][i]
            
            if(imageName != ""){
                myImageView!.image=UIImage(named: imageName)?.roundedImage
            }
        }
    }
    
    func setSlider(){
        var infoArray=returnInfoArray()
        slider.minimumValue=0
        slider.maximumValue=Float(infoArray.count-1)
        slider.setValue(Float(pageCount), animated: true)
        pageCountLabel.text="\(pageCount+1)/\(infoArray.count)"
    }
    
    func returnInfoArray() -> [[String]]{
        var countryName: String=UserDefaults.standard.string(forKey: "countryName")!
        var countryArray: [String: [[String]]]=allCountryInfo[countryName]![0]
        
        var infoType: String=UserDefaults.standard.string(forKey: "infoType")!
        var infoArray: [[String]]=countryArray[infoType]!
        
        return infoArray
    }
    
    func returnImageArray() -> [[String]]{
        var countryName: String=UserDefaults.standard.string(forKey: "countryName")!
        var allImages: [String: [[String]]]=allCountryInfo[countryName]![1]
        
        var infoType: String=UserDefaults.standard.string(forKey: "infoType")!
        var infoImageArray: [[String]]=allImages[infoType]!
        
        return infoImageArray
    }
    
    @IBAction func backPressed(_ sender: Any) {
        var infoArray=returnInfoArray()
        if(pageCount>0){
            pageCount-=1
            setSlider()
            setUpPage()
        }
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        var infoArray=returnInfoArray()
        if(pageCount<infoArray.count-1){
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
