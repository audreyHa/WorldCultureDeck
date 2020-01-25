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
        ["South Korea":[["Question 1 Question 1 Question 1 Question 1 Question 1 Question 1 Question 1 Question 1 Question 1 Question 1 Question 1 Question 1 Question 1 Question 1 Question 1 ", "  Option 1a Option 1a Option 1a Option 1a", "  Option 2a", "  Option 3a"], ["Question 2","  Option 1b", "  Option 2b", "  Option 3b"]]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.layer.cornerRadius=10
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
        }
        return cell
    }
}
