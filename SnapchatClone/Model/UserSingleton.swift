//
//  UserSingleton.swift
//  SnapchatClone
//
//  Created by Andrew  on 3/17/23.
//

import Foundation

class UserSingleton {
    
    static let sharedUserInfo = UserSingleton()
    
    var email = ""
    var username = ""
    
    private init() {
        
    }
    
}
