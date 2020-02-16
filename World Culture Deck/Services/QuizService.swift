//
//  QuizService.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 2/1/20.
//  Copyright © 2020 AudreyHa. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct QuizService{
    static func saveScore(quizScore: Int){
        let currentUID=User.current.uid
        var countryName: String=UserDefaults.standard.string(forKey: "countryName")!
        var shouldIncrement=false
        var incrementBy=0
        
        let quizRef=Database.database().reference().child("quizScores").child(countryName).child(currentUID)
        var currentScore="0"
        quizRef.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            currentScore = snapshot.value as? String ?? "0" //just set variable currentScore to 0 if that quiz has never been taken before
            
            incrementBy=quizScore-Int(currentScore)!
            print("incrementBy \(incrementBy)")
                   
            if(incrementBy>0){
               //set the user's new quiz score
               quizRef.setValue(String(quizScore)){(error, _) in
                   if let error=error{
                       assertionFailure(error.localizedDescription)
                   }

                   //increasing the user's stars if they got more points than their last score
                   let starCountRef=Database.database().reference().child("users").child(currentUID).child("stars")
                   starCountRef.runTransactionBlock({(mutableData) -> TransactionResult in
                       let currentStarCount=mutableData.value as? String ?? "0"
                       mutableData.value=String(Int(currentStarCount)!+(incrementBy*10))
                       return TransactionResult.success(withValue: mutableData)
                       
                   }, andCompletionBlock: {(error,_,_) in
                       if let error=error{
                           assertionFailure(error.localizedDescription)
                       }
                   })
               }
           }
        })
    }
    
    static func displayQuizScore(myLabel: UILabel){
        let currentUID=User.current.uid
        var countryName: String=UserDefaults.standard.string(forKey: "countryName")!
        let quizRef=Database.database().reference().child("quizScores").child(countryName).child(currentUID)
        var currentScore="0"
        
        quizRef.observe(.value, with: { (snapshot) in
            // Get user value
            currentScore = snapshot.value as? String ?? "0" //just set variable currentScore to 0 if that quiz has never been taken before
            if(currentScore=="0"){
                myLabel.text = ""
            }else{
                myLabel.text = "Top Score: \(currentScore)/3"
            }
        })
    }
    
    static func removeAllObservers(){
        print("removing observers")
        let currentUID=User.current.uid
        var countryName: String=UserDefaults.standard.string(forKey: "countryName")!
        let quizRef=Database.database().reference().child("quizScores").child(countryName).child(currentUID)
        quizRef.removeAllObservers()
    }
}
