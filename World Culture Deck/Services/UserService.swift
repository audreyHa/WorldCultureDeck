//
//  UserService.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 12/30/19.
//  Copyright © 2019 AudreyHa. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct UserService{
    static func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void){
        //2 Create a dictionary to store the username that the user has provided inside our database
        let userAttrs=["username":username]
        
        //3 Specify relative path for location where we want to store our data
        let ref=Database.database().reference().child("users").child(firUser.uid)
        
        //4 Write data we want to store at location provided in step 3
        ref.setValue(userAttrs){(error, ref) in
            if let error=error{
                assertionFailure(error.localizedDescription)
                return
            }
            
            //5 Read user we just wrote to database and create user from the snapshot
            ref.observeSingleEvent(of: .value, with: {(snapshot) in
                let user=User(snapshot: snapshot)
                completion(user)
            })
        }
    }
    
    static func show(forUID uid: String, completion: @escaping (User?) -> Void){
        let ref=Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            guard let user=User(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(user)
        })
    }
}
