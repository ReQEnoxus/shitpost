//
//  SignUpPresenterInput.swift
//  Shitpost
//
//  Created by Enoxus on 11.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol SignUpPresenterInput: AnyObject {
    
    func signUpFinished(with response: SignUpResponse)
}
