  
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
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var xButton: UIButton!
    
    var userAnswersString: [String]=["","",""]
    var userAnswers: [String]=["","",""]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WCDLabel.adjustsFontSizeToFitWidth=true
        UserDefaults.standard.set(false,forKey:"NLI_isFeedback")
        submitButton.layer.cornerRadius=10

        NotificationCenter.default.addObserver(self, selector: #selector(self.newAnswerPressed(notification:)), name: Notification.Name("newAnswerPressed"), object: nil)
        
        tableView.allowsSelection=false
        
        var countryName=UserDefaults.standard.string(forKey: "NLI_countryName")!
        headerLabel.text="\(countryName): Quiz"
        
        xButton.accessibilityLabel="Close quiz page"
        xButton.accessibilityHint="Tap to go back to \(countryName) page"
        redoButton.accessibilityLabel="Redo Quiz"
        
        var myLabels=[WCDLabel, topScoreLabel, headerLabel]
        var myButtons=[submitButton]
        
        for myLabel in myLabels{
            makeLabelAccessible(myLabel: myLabel!)
        }
        
        for myButton in myButtons{
            makeButtonAccessible(myButton: myButton!)
        }
    }

    func makeLabelAccessible(myLabel: UILabel){
        myLabel.adjustsFontForContentSizeCategory=true
        myLabel.adjustsFontSizeToFitWidth=true
        myLabel.font=UIFontMetrics.default.scaledFont(for: myLabel.font)
    }
    
    func makeButtonAccessible(myButton: UIButton){
        myButton.titleLabel!.adjustsFontForContentSizeCategory=true
        myButton.titleLabel!.adjustsFontSizeToFitWidth=true
        myButton.titleLabel!.font=UIFontMetrics.default.scaledFont(for: myButton.titleLabel!.font)
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
            
            UIAccessibility.post(notification: .screenChanged, argument: topScoreLabel)
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
        cell.questionLabel.accessibilityLabel="Question \(indexPath.row + 1) out of 3: \(questions![numberWords[indexPath.row]]!["zero"]!)"
        

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
                    cell.firstOption.accessibilityLabel = "Correct Answer: " + questions![numberWords[indexPath.row]]![numberWords[1]]!
                case "B":
                    self.setButtonSelected(myButton: cell.secondOption)
                    cell.secondOption.accessibilityLabel = "Correct Answer: " + questions![numberWords[indexPath.row]]![numberWords[2]]!
                default:
                    self.setButtonSelected(myButton: cell.thirdOption)
                    cell.thirdOption.accessibilityLabel = "Correct Answer: " + questions![numberWords[indexPath.row]]![numberWords[3]]!
                }
                    
                switch(self.userAnswers[correctIndex]){
                case "A":
                    self.setButtonRed(myButton: cell.firstOption)
                    cell.firstOption.accessibilityLabel = "Incorrect Answer: " + questions![numberWords[indexPath.row]]![numberWords[1]]!
                case "B":
                    self.setButtonRed(myButton: cell.secondOption)
                    cell.secondOption.accessibilityLabel = "Incorrect Answer: " + questions![numberWords[indexPath.row]]![numberWords[2]]!
                default:
                    self.setButtonRed(myButton: cell.thirdOption)
                    cell.thirdOption.accessibilityLabel = "Incorrect Answer: " + questions![numberWords[indexPath.row]]![numberWords[3]]!
                }
            }else{
                switch(self.userAnswers[correctIndex]){
                case "A":
                    self.setButtonSelected(myButton: cell.firstOption)
                    cell.firstOption.accessibilityLabel = "Correct Answer: " + questions![numberWords[indexPath.row]]![numberWords[1]]!
                case "B":
                    self.setButtonSelected(myButton: cell.secondOption)
                    cell.secondOption.accessibilityLabel = "Correct Answer: " + questions![numberWords[indexPath.row]]![numberWords[2]]!
                default:
                    self.setButtonSelected(myButton: cell.thirdOption)
                    cell.thirdOption.accessibilityLabel = "Correct Answer: " + questions![numberWords[indexPath.row]]![numberWords[3]]!
                }
            }

        }else{
            for i in 1...3{
                var myButton=optionButtons[i-1]
                myButton!.layer.cornerRadius=10
                myButton!.titleLabel?.adjustsFontSizeToFitWidth=true
                
                var optionTitle=questions![numberWords[indexPath.row]]![numberWords[i]]
                myButton!.setTitle(optionTitle, for: .normal)
                myButton!.accessibilityLabel="\(optionTitle!)"
                self.setButtonUNSelected(myButton: myButton!)
                
                myButton!.accessibilityLabel="\(optionTitle!)"
                
                for answer in self.userAnswersString{
                    if(answer==optionTitle){
                        self.setButtonSelected(myButton: myButton!)
                        myButton!.accessibilityLabel="\(optionTitle!): Currently Selected"
                    }
                }
            }
        }

        cell.selectionStyle = .none
        cell.isAccessibilityElement=false
        cell.questionSurrounding.isAccessibilityElement=false
        cell.questionLabel.isAccessibilityElement=true
        cell.firstOption.isAccessibilityElement=true
        cell.secondOption.isAccessibilityElement=true
        cell.thirdOption.isAccessibilityElement=true
        
        return cell
    }

    var mintColor: UIColor=UIColor(red: 215.0/255.0, green: 241.0/255.0, blue: 227.0/255.0, alpha: 1.0)
    var tealColor: UIColor=UIColor(red: 8.0/255.0, green: 164.0/255.0, blue: 157.0/255.0, alpha: 1.0)
    var redColor: UIColor=UIColor(red: 213.0/255.0, green: 99.0/255.0, blue: 99.0/255.0, alpha: 1.0)

    func setButtonSelected(myButton: UIButton){
        myButton.backgroundColor=mintColor
        myButton.setTitleColor(UIColor.black, for: .normal)
    }

    func setButtonRed(myButton: UIButton){
        myButton.backgroundColor=redColor
        myButton.setTitleColor(UIColor.white, for: .normal)
    }

    func setButtonUNSelected(myButton: UIButton){
        myButton.backgroundColor=tealColor
        myButton.setTitleColor(UIColor.white, for: .normal)
    }
}
