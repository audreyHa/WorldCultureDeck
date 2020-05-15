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
                            
                        var totalStars=Int(currentStarCount)!+(incrementBy*10)
                        if(totalStars>=300){
                            let badge300Ref=Database.database().reference().child("users").child(currentUID).child("Badges").child("300 Stars")
                            
                             badge300Ref.setValue(true){(error, _) in
                                 if let error=error{
                                     assertionFailure(error.localizedDescription)
                                 }
                             }
                        }else if(totalStars>=200){
                            let badge200Ref=Database.database().reference().child("users").child(currentUID).child("Badges").child("200 Stars")
                            
                             badge200Ref.setValue(true){(error, _) in
                                 if let error=error{
                                     assertionFailure(error.localizedDescription)
                                 }
                             }
                        }else if(totalStars>=100){
                            let badge100Ref=Database.database().reference().child("users").child(currentUID).child("Badges").child("100 Stars")
                            
                             badge100Ref.setValue(true){(error, _) in
                                 if let error=error{
                                     assertionFailure(error.localizedDescription)
                                 }
                             }
                        }
                            
                        //checking if most recent quiz score was 3/3
                        if((incrementBy+Int(currentScore)!)==3){
                            let currentUID=User.current.uid
                            
                            //Set a country as completed if the quiz score was 3/3
                            let completedRef=Database.database().reference().child("users").child(currentUID).child("Completed Countries").child(countryName)
                           
                            completedRef.setValue(true){(error, _) in
                                if let error=error{
                                    assertionFailure(error.localizedDescription)
                                }
                            }
                            
                            NotificationCenter.default.post(name: Notification.Name("newDeckCompleted"), object: nil)
                            print("sending noti for new deck completed")
                        }
                    
                       return TransactionResult.success(withValue: mutableData)
                           
                   }, andCompletionBlock: {(error,_,_) in
                       if let error=error{
                           assertionFailure(error.localizedDescription)
                       }
                   })
                    
                
                    //updating quiz correct count
                   let quizCountRef=Database.database().reference().child("users").child(currentUID).child("quizCount")
                    quizCountRef.runTransactionBlock({(mutableData) -> TransactionResult in
                        let currentQuizCount=mutableData.value as? String ?? "0"
                        mutableData.value=String(Int(currentQuizCount)!+(incrementBy))
                        
                        NotificationCenter.default.post(name: Notification.Name("updateSettings"), object: nil)
                        
                        return TransactionResult.success(withValue: mutableData)
                        
                    }, andCompletionBlock: {(error,_,_) in
                        if let error=error{
                            assertionFailure(error.localizedDescription)
                        }
                    })
                    
                    //updating quiz total count if this is a new quiz
                    if(currentScore=="0"){
                        let quizTotalRef=Database.database().reference().child("users").child(currentUID).child("quizTotal")
                        quizTotalRef.runTransactionBlock({(mutableData) -> TransactionResult in
                            let currentQuizTotalCount=mutableData.value as? String ?? "0"
                            mutableData.value=String(Int(currentQuizTotalCount)!+3)
                            
                            NotificationCenter.default.post(name: Notification.Name("updateSettings"), object: nil)
                            
                            return TransactionResult.success(withValue: mutableData)
                            
                        }, andCompletionBlock: {(error,_,_) in
                            if let error=error{
                                assertionFailure(error.localizedDescription)
                            }
                        })
                    }
                    
                    
                }
            } //end of if incrementBy>0
        })
        
        NotificationCenter.default.post(name: Notification.Name("updateBadgeCollectionView"), object: nil)
    }
    
    static func displayQuizScore(myLabel: UILabel){
        let currentUID=User.current.uid
        var countryName: String=UserDefaults.standard.string(forKey: "countryName")!
        print("Displaying top score: \(countryName)")
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
