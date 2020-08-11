//
//  AuthInteractorInput.swift
//  Shitpost
//
//  Created by Enoxus on 10.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol AuthInteractorInput: AnyObject {
    
    func login(with request: LoginRequest)
}
