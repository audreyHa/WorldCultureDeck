//
//  NLI_QuizController.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 2/18/20.
//  Copyright © 2020 AudreyHa. All rights reserved.
//

import UIKit

class NLI_QuizController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var topScoreLabel: UILabel!
    @IBOutlet weak var redoButton: UIButton!
    @IBOutlet weak var WCDLabel: UILabel!

    var userAnswersString: [String]=["","",""]
    var userAnswers: [String]=["","",""]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WCDLabel.adjustsFontSizeToFitWidth=true
        UserDefaults.standard.set(false,forKey:"NLI_isFeedback")
        submitButton.layer.cornerRadius=10

        NotificationCenter.default.addObserver(self, selector: #selector(self.newAnswerPressed(notification:)), name: Notification.Name("newAnswerPressed"), object: nil)
        
        tableView.allowsSelection=false
    }

    @objc func newAnswerPressed(notification: Notification) {
        var answer=UserDefaults.standard.string(forKey: "NLI_newAnswer")
        var index=UserDefaults.standard.integer(forKey: "NLI_newAnswerIndex")
        var letter=UserDefaults.standard.string(forKey: "NLI_letter")
        userAnswersString[index]=answer!
        userAnswers[index]=letter!
        
        tableView.reloadData()
    }

    func returnCountryQuizQuestions() -> [String:[String:String]] {
        var countryName=UserDefaults.standard.string(forKey: "NLI_countryName")!
        let allQuizzes=InfoService.returnQuizInfo()
        return allQuizzes[countryName]!["Quiz Questions"]!
    }

    func returnCorrectAnswers() -> [String:[String]] {
        let correctAnswersDict=["Ghana":["A","C","C"],"Lebanon":["C","A","B"],"Mexico":["B","A","C"],"Navajo Nation":["B","A","C"],"Norway":["A","A","B"],"Peru":["A","A","C"],"Roma":["B","A","C"],"South Africa":["C","C","B"],"South Korea":["B","C","B"],"Tonga":["C","B","C"]]
        
        return correctAnswersDict
    }

    @IBAction func submitPressed(_ sender: Any) {
        let isFeedback=UserDefaults.standard.bool(forKey: "NLI_isFeedback")
        if(isFeedback==false){
            UserDefaults.standard.set(true,forKey:"NLI_isFeedback")
            tableView.reloadData()
            
            let countryName=UserDefaults.standard.string(forKey: "NLI_countryName")!
            let correctAnswersArray=returnCorrectAnswers()
            
            var totalCorrect=0
            
            for i in 0...correctAnswersArray[countryName]!.count-1{
                if(userAnswers[i] == correctAnswersArray[countryName]![i]){
                    totalCorrect+=1
                }
            }
            
            topScoreLabel.text="Score: \(totalCorrect)/3"
        }
        
    }

    @IBAction func redoPressed(_ sender: Any) {
        UserDefaults.standard.set(false,forKey:"NLI_isFeedback")
        userAnswersString=["","",""]
        userAnswers=["","",""]
        tableView.reloadData()
    }

    @IBAction func xPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NLI_quizCell", for: indexPath) as! NLI_quizCell
        
        cell.questionSurrounding.layer.cornerRadius=10
        let numberWords=["zero","one","two","three","four","five","six"]
        let countryName=UserDefaults.standard.string(forKey: "NLI_countryName")!
        let optionButtons=[cell.firstOption, cell.secondOption, cell.thirdOption]
        
        let questions=InfoService.returnQuizInfo()[countryName]!["Quiz Questions"]
        cell.questionLabel.text=questions![numberWords[indexPath.row]]!["zero"]
        
        
        
        
        let isFeedback=UserDefaults.standard.bool(forKey: "NLI_isFeedback")
        if(isFeedback){
            for i in 1...3{
                let myButton=optionButtons[i-1]
                myButton!.layer.cornerRadius=10
                myButton!.titleLabel?.adjustsFontSizeToFitWidth=true
                
                let optionTitle=questions![numberWords[indexPath.row]]![numberWords[i]]
                myButton?.setTitle(optionTitle, for: .normal)
                self.setButtonUNSelected(myButton: myButton!)
            }
            
            let correctAnswersArray=self.returnCorrectAnswers()
            var correctIndex=0
            
            for j in 0...2{
                if((questions![numberWords[j]]!["zero"]==cell.questionLabel.text! || questions![numberWords[j]]!["one"]==cell.questionLabel.text!)||questions![numberWords[j]]!["two"]==cell.questionLabel.text!){
                    correctIndex=j
                }
            }
            
            if(correctAnswersArray[countryName]![correctIndex] != self.userAnswers[correctIndex]){
                switch(correctAnswersArray[countryName]![correctIndex]){
                case "A":
                    self.setButtonSelected(myButton: cell.firstOption)
                case "B":
                    self.setButtonSelected(myButton: cell.secondOption)
                default:
                    self.setButtonSelected(myButton: cell.thirdOption)
                }
                    
                switch(self.userAnswers[correctIndex]){
                case "A":
                    self.setButtonRed(myButton: cell.firstOption)
                case "B":
                    self.setButtonRed(myButton: cell.secondOption)
                default:
                    self.setButtonRed(myButton: cell.thirdOption)
                }
            }else{
                switch(self.userAnswers[correctIndex]){
                case "A":
                    self.setButtonSelected(myButton: cell.firstOption)
                case "B":
                    self.setButtonSelected(myButton: cell.secondOption)
                default:
                    self.setButtonSelected(myButton: cell.thirdOption)
                }
            }

        }else{
            for i in 1...3{
                var myButton=optionButtons[i-1]
                myButton!.layer.cornerRadius=10
                myButton!.titleLabel?.adjustsFontSizeToFitWidth=true
                
                var optionTitle=questions![numberWords[indexPath.row]]![numberWords[i]]
                myButton?.setTitle(optionTitle, for: .normal)
                self.setButtonUNSelected(myButton: myButton!)
                
                for answer in self.userAnswersString{
                    if(answer==optionTitle){
                        self.setButtonSelected(myButton: myButton!)
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
