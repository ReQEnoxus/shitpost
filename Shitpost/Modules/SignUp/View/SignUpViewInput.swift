//
//  SignUpViewInput.swift
//  Shitpost
//
//  Created by Enoxus on 11.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol SignUpViewInput: AnyObject {
    
    func showMalformedFieldError(field: String, error: String)
    
    func showInvalidCredentialsError(_ error: String)
}
