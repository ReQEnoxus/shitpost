//
//  AuthService.swift
//  Shitpost
//
//  Created by Enoxus on 11.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Firebase

class AuthService: AuthServiceProtocol {
    
    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            self?.processUser(result, error, completion: completion)
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            self?.processUser(result, error, completion: completion)
        }
    }
    
    func signOut(completion: (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.set(false, forKey: Constants.UserDefaults.Keys.isAuthenticated)
            completion(nil)
        }
        catch let error {
            completion(error)
        }
    }
    
    fileprivate func processUser(_ result: AuthDataResult?, _ error: Error?, completion: @escaping (Result<User, Error>) -> Void) {
        
        if let error = error {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
        else if let result = result {
            
            let resultUser = result.user
            guard let userEmail = resultUser.email else { return }
            let user = User(email: userEmail)
            
            UserDefaults.standard.set(true, forKey: Constants.UserDefaults.Keys.isAuthenticated)
            
            DispatchQueue.main.async {
                completion(.success(user))
            }
        }
    }
}
