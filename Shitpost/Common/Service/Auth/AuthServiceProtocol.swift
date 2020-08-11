//
//  AuthServiceProtocol.swift
//  Shitpost
//
//  Created by Enoxus on 11.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol AuthServiceProtocol: AnyObject {
    
    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    
    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    
    func signOut(completion: (Error?) -> Void)
}
