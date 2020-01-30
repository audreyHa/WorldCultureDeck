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
    @IBOutlet weak var redoButton: UIButton!
    
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
    
    var allCountryCorrectAnswers: [String: [String]]=["South Korea":["A","B","C","B","C","A","B","B","A"]]
    
    var userAnswersString: [String]=["","","","","","","","",""]
    var userAnswers: [String]=["","","","","","","","",""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(false,forKey:"isFeedback")
        submitButton.layer.cornerRadius=10
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.newAnswerPressed(notification:)), name: Notification.Name("newAnswerPressed"), object: nil)
        
        tableView.allowsSelection=false
    }
    
    @objc func newAnswerPressed(notification: Notification) {
        var answer=UserDefaults.standard.string(forKey: "newAnswer")
        var index=UserDefaults.standard.integer(forKey: "newAnswerIndex")
        var letter=UserDefaults.standard.string(forKey: "letter")
        userAnswersString[index]=answer!
        userAnswers[index]=letter!
        
        tableView.reloadData()
    }
    
    func returnCountryQuizArray() -> [[String]]{
        var countryName: String=UserDefaults.standard.string(forKey: "countryName")!
        var countryQuizArray: [[String]]=allCountryQuizzes[countryName]!
        
        return countryQuizArray
    }
    
    func returnCorrectAnswersArray() -> [String]{
        var countryName: String=UserDefaults.standard.string(forKey: "countryName")!
        var countryQuizArray: [String]=allCountryCorrectAnswers[countryName]!
        
        return countryQuizArray
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        var isFeedback=UserDefaults.standard.bool(forKey: "isFeedback")
        if(isFeedback==nil || isFeedback==false){
            UserDefaults.standard.set(true,forKey:"isFeedback")
            tableView.reloadData()
        }
        
        var correctAnswersArray=returnCorrectAnswersArray()
        var totalQuestionNumber=correctAnswersArray.count
        var totalCorrect=totalQuestionNumber
        for i in 0...correctAnswersArray.count-1{
            if(userAnswers[i] != correctAnswersArray[i]){
                totalCorrect-=1
            }
        }
        
        topScoreLabel.text="Top Score: \(totalCorrect)/\(totalQuestionNumber)"
    }
    
    @IBAction func redoPressed(_ sender: Any) {
        UserDefaults.standard.set(false,forKey:"isFeedback")
        userAnswersString=["","","","","","","","",""]
        userAnswers=["","","","","","","","",""]
        tableView.reloadData()
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
        
        var isFeedback=UserDefaults.standard.bool(forKey: "isFeedback")
        if(isFeedback){
            for i in 1...3{
                var myButton=optionButtons[i-1]
                myButton!.layer.cornerRadius=10
                myButton!.titleLabel?.adjustsFontSizeToFitWidth=true
                
                var optionTitle=countryQuizArray[indexPath.row][i]
                myButton?.setTitle(optionTitle, for: .normal)
                setButtonUNSelected(myButton: myButton!)
            }
            
            var correctAnswersArray=returnCorrectAnswersArray()
            var correctIndex=0
            
            for i in 0...countryQuizArray.count-1{
                if(countryQuizArray[i].contains(cell.questionLabel.text!)){
                    correctIndex=i
                }
            }
            
            print(correctIndex)
            
            if(correctAnswersArray[correctIndex] != userAnswers[correctIndex]){
                switch(correctAnswersArray[correctIndex]){
                case "A":
                    setButtonSelected(myButton: cell.firstOption)
                case "B":
                    setButtonSelected(myButton: cell.secondOption)
                default:
                    setButtonSelected(myButton: cell.thirdOption)
                }
                    
                switch(userAnswers[correctIndex]){
                case "A":
                    setButtonRed(myButton: cell.firstOption)
                case "B":
                    setButtonRed(myButton: cell.secondOption)
                default:
                    setButtonRed(myButton: cell.thirdOption)
                }
            }else{
                switch(userAnswers[correctIndex]){
                case "A":
                    setButtonSelected(myButton: cell.firstOption)
                case "B":
                    setButtonSelected(myButton: cell.secondOption)
                default:
                    setButtonSelected(myButton: cell.thirdOption)
                }
            }

        }else{
            for i in 1...3{
                var myButton=optionButtons[i-1]
                myButton!.layer.cornerRadius=10
                myButton!.titleLabel?.adjustsFontSizeToFitWidth=true
                
                var optionTitle=countryQuizArray[indexPath.row][i]
                
                myButton?.setTitle(optionTitle, for: .normal)
                setButtonUNSelected(myButton: myButton!)
                
                for answer in userAnswersString{
                    if(answer==optionTitle){
                        setButtonSelected(myButton: myButton!)
                    }
                }
            }
        }
        
        return cell
    }
    
    var mintColor: UIColor=UIColor(red: 215.0/255.0, green: 241.0/255.0, blue: 227.0/255.0, alpha: 1.0)
    var tealColor: UIColor=UIColor(red: 8.0/255.0, green: 164.0/255.0, blue: 157.0/255.0, alpha: 1.0)
    var redColor: UIColor=UIColor(red: 213.0/255.0, green: 99.0/255.0, blue: 99.0/255.0, alpha: 1.0)
    
    func setButtonSelected(myButton: UIButton){
        myButton.backgroundColor=mintColor
        myButton.setTitleColor(tealColor, for: .normal)
    }
    
    func setButtonRed(myButton: UIButton){
        myButton.backgroundColor=redColor
        myButton.setTitleColor(mintColor, for: .normal)
    }
    
    func setButtonUNSelected(myButton: UIButton){
        myButton.backgroundColor=tealColor
        myButton.setTitleColor(mintColor, for: .normal)
    }
    
    
}
