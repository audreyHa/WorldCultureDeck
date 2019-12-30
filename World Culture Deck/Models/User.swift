//
//  User.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 12/30/19.
//  Copyright © 2019 AudreyHa. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class User: Codable{
    let uid: String
    let username: String
    
    //1 create private static variable to hold our current user
    private static var _current: User?

    //2 Create a computed variable that can access private _current variable
    static var current: User{
        //3
        guard let currentUser = _current else{
            fatalError("Error: current user doesn't exist")
        }
        
        //4
        return currentUser
    }

    //5 Custom setter method to set the current user
    static func setCurrent(_ user: User, writeToUserDefaults: Bool=false){
        if writeToUserDefaults{
            //3 User JSONEncoder to turn our object into Data
            if let data=try? JSONEncoder().encode(user){
                //4 Store data for our current user in User Defaults
                UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
            }
        }
        
        _current=user
    }
    
    init(uid: String, username: String){
        self.uid=uid
        self.username=username
    }
    
    init?(snapshot: DataSnapshot){
        guard let dict=snapshot.value as? [String:Any],
            let username=dict["username"] as? String
            else {return nil}
        
        self.uid=snapshot.key
        self.username=username
    }
}
