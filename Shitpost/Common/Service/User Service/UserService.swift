//
//  UserService.swift
//  Shitpost
//
//  Created by Enoxus on 14.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Firebase

class UserService: UserServiceProtocol {
    
    var currentUser: User? {
        let current = Auth.auth().currentUser
        
        guard let unwrapped = current, let email = unwrapped.email else { return nil }
        return User(email: email)
    }
}
