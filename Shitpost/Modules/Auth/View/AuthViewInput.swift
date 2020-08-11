//
//  AuthViewInput.swift
//  Shitpost
//
//  Created by Enoxus on 10.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol AuthViewInput: AnyObject {
    
    func showEmailError(_ error: String)
    
    func showPasswordError(_ error: String)
    
    func showInvalidCredentialsError(_ error: String)
}
