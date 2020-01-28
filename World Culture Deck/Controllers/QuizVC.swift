//
//  QuizVC.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 1/24/20.
//  Copyright © 2020 AudreyHa. All rights reserved.
//

import UIKit

class QuizVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var topScoreLabel: UILabel!
    
    var allCountryQuizzes: [String: [[String]]] =
        ["South Korea":[
            ["The traditional Korean Hanbok is worn for what type of event?", "  Only special occasions or Korean holidays", "  Every day", "  On weekends"],
            ["For women, a Hanbok consists of what?","  Pants and jeans", "  Fitted top jacket and wide, flexible skirt", "  Vest and pants"],
            ["What is the name of the most popular K-pop group?","  KBS", "  ABC", "  BTS"],
            ["Arirang is the most famous/culturally important Korean folk song. Which of the following is true?","  There is only one variation of Arirang in Korea", "  Different regions have their own musical and lyrical variations", "  Only Eastern parts of Korea sing Arirang today"],
            ["Kimchi is:","  A type of Korean painting style", "  A major city in South Korea", "  A spicy, salty, fermented cabbage dish"],
            ["During the Joseon dynasty, Korean paintings transitioned from:","  Idealized landscapes >>> Day-to-day illustrations of people", "  Paintings of war >>> Landscape paintings", "  Paintings of animals >>> Paintings of oceans"],
            ["What were the 3 main types of Korean pottery?","  Pottery with dragons, flowers, or animal designs", "  Blue-green, white porcelain, stone", "  Trick question--white porcelain is the only type of Korean pottery"],
            ["Which of the following are 2 types of Korean meat:","  Kimchi and Bibimpap", "  Bulgogi and Galbi", "  Seoul and Busan"],
            ["What is the capital of South Korea?","  Seoul", "  Busan", "  Incheon"]]]
    
    var quizAnswers: [String]=["","","","","","","","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.layer.cornerRadius=10
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.newAnswerPressed(notification:)), name: Notification.Name("newAnswerPressed"), object: nil)
    }
    
    @objc func newAnswerPressed(notification: Notification) {
        var answer=UserDefaults.standard.string(forKey: "newAnswer")
        var index=UserDefaults.standard.integer(forKey: "newAnswerIndex")
        quizAnswers[index]=answer!
        
        tableView.reloadData()
    }
    
    func returnCountryQuizArray() -> [[String]]{
        var countryName: String=UserDefaults.standard.string(forKey: "countryName")!
        var countryQuizArray: [[String]]=allCountryQuizzes[countryName]!
        
        return countryQuizArray
    }
    
    @IBAction func submitPressed(_ sender: Any) {
    }
    
    @IBAction func xPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countryQuizArray=returnCountryQuizArray()
        
        return countryQuizArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath) as! QuizCell
        
        cell.questionSurrounding.layer.cornerRadius=10
        
        var countryQuizArray=returnCountryQuizArray()
        cell.questionLabel.text=countryQuizArray[indexPath.row][0]
        
        var optionButtons=[cell.firstOption, cell.secondOption, cell.thirdOption]
        
        for i in 1...3{
            var myButton=optionButtons[i-1]
            myButton!.layer.cornerRadius=10
            myButton!.titleLabel?.adjustsFontSizeToFitWidth=true
            
            var optionTitle=countryQuizArray[indexPath.row][i]
            print(optionTitle)
            myButton?.setTitle(optionTitle, for: .normal)
            setButtonUNSelected(myButton: myButton!)
            
            for answer in quizAnswers{
                if(answer==optionTitle){
                    setButtonSelected(myButton: myButton!)
                }
            }
        }
        return cell
    }
    
    var mintColor: UIColor=UIColor(red: 215.0/255.0, green: 241.0/255.0, blue: 227.0/255.0, alpha: 1.0)
    var tealColor: UIColor=UIColor(red: 8.0/255.0, green: 164.0/255.0, blue: 157.0/255.0, alpha: 1.0)
    
    func setButtonSelected(myButton: UIButton){
        myButton.backgroundColor=mintColor
        myButton.setTitleColor(tealColor, for: .normal)
    }
    
    func setButtonUNSelected(myButton: UIButton){
        myButton.backgroundColor=tealColor
        myButton.setTitleColor(mintColor, for: .normal)
    }
    
    
}
