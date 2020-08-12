//
//  SignUpInteractorInput.swift
//  Shitpost
//
//  Created by Enoxus on 11.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol SignUpInteractorInput: AnyObject {
    
    func signUp(with request: SignUpRequest)
}
