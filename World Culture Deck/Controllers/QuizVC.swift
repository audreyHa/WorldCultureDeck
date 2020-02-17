//
//  QuizVC.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 1/24/20.
//  Copyright © 2020 AudreyHa. All rights reserved.
//

import UIKit
import FirebaseDatabase

class QuizVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var topScoreLabel: UILabel!
    @IBOutlet weak var redoButton: UIButton!
    @IBOutlet weak var starLabel: UILabel!

    var userAnswersString: [String]=["","",""]
    var userAnswers: [String]=["","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(false,forKey:"isFeedback")
        submitButton.layer.cornerRadius=10

        NotificationCenter.default.addObserver(self, selector: #selector(self.newAnswerPressed(notification:)), name: Notification.Name("newAnswerPressed"), object: nil)
        
        tableView.allowsSelection=false
        
        QuizService.displayQuizScore(myLabel: topScoreLabel)
        StarService.displayStars(myLabel: starLabel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkNetwork()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      QuizService.removeAllObservers()
    }
    
    @objc func newAnswerPressed(notification: Notification) {
        var answer=UserDefaults.standard.string(forKey: "newAnswer")
        var index=UserDefaults.standard.integer(forKey: "newAnswerIndex")
        var letter=UserDefaults.standard.string(forKey: "letter")
        userAnswersString[index]=answer!
        userAnswers[index]=letter!
        
        tableView.reloadData()
    }
    
    func returnCountryQuizQuestions(completionHandler: @escaping ([String:[String:String]]) -> Void) {
        var countryName=UserDefaults.standard.string(forKey: "countryName")!
        let quizRef=Database.database().reference().child("quizInfo").child(countryName).child("Quiz Questions")
        
        quizRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! [String:[String:String]]
            completionHandler(value)
        })
    }

    func returnCorrectAnswers() -> [String:[String]] {
        let correctAnswersDict=["Ghana":["A","C","C"],"Lebanon":["C","A","B"],"Mexico":["B","A","C"],"Navajo Nation":["B","A","C"],"Norway":["A","A","B"],"Peru":["A","A","C"],"Roma":["B","A","C"],"South Africa":["C","C","B"],"South Korea":["B","C","B"],"Tonga":["C","B","C"]]
        
        return correctAnswersDict
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        let isFeedback=UserDefaults.standard.bool(forKey: "isFeedback")
        if(isFeedback==false){
            UserDefaults.standard.set(true,forKey:"isFeedback")
            tableView.reloadData()
            
            let countryName=UserDefaults.standard.string(forKey: "countryName")!
            let correctAnswersArray=returnCorrectAnswers()
            
            var totalCorrect=0
            
            for i in 0...correctAnswersArray[countryName]!.count-1{
                if(userAnswers[i] == correctAnswersArray[countryName]![i]){
                    totalCorrect+=1
                }
            }

            QuizService.saveScore(quizScore: totalCorrect)
            DispatchQueue.main.async{
                QuizService.displayQuizScore(myLabel: self.topScoreLabel)
            }
           
            StarService.displayStars(myLabel: starLabel)
        }
        
    }
    
    @IBAction func redoPressed(_ sender: Any) {
        UserDefaults.standard.set(false,forKey:"isFeedback")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath) as! QuizCell
        
        cell.questionSurrounding.layer.cornerRadius=10
        let numberWords=["zero","one","two","three","four","five","six"]
        
        self.returnCountryQuizQuestions{value in

            cell.questionLabel.text=value[numberWords[indexPath.row]]!["zero"]
            
            let optionButtons=[cell.firstOption, cell.secondOption, cell.thirdOption]
            let countryName=UserDefaults.standard.string(forKey: "countryName")!
            
            let isFeedback=UserDefaults.standard.bool(forKey: "isFeedback")
            if(isFeedback){
                for i in 1...3{
                    let myButton=optionButtons[i-1]
                    myButton!.layer.cornerRadius=10
                    myButton!.titleLabel?.adjustsFontSizeToFitWidth=true
                    
                    let optionTitle=value[numberWords[indexPath.row]]![numberWords[i]]
                    myButton?.setTitle(optionTitle, for: .normal)
                    self.setButtonUNSelected(myButton: myButton!)
                }
                
                let correctAnswersArray=self.returnCorrectAnswers()
                var correctIndex=0
                
                for j in 0...2{
                    if((value[numberWords[j]]!["zero"]==cell.questionLabel.text! || value[numberWords[j]]!["one"]==cell.questionLabel.text!)||value[numberWords[j]]!["two"]==cell.questionLabel.text!){
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
                    
                    var optionTitle=value[numberWords[indexPath.row]]![numberWords[i]]
                    myButton?.setTitle(optionTitle, for: .normal)
                    self.setButtonUNSelected(myButton: myButton!)
                    
                    for answer in self.userAnswersString{
                        if(answer==optionTitle){
                            self.setButtonSelected(myButton: myButton!)
                        }
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
