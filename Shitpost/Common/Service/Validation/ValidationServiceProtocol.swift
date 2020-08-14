//
//  ValidationServiceProtocol.swift
//  Shitpost
//
//  Created by Enoxus on 11.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ValidationServiceProtocol: AnyObject {
    
    func validate(signUpRequest: SignUpRequest) -> ValidationResponse
    
    func validate(loginRequest: LoginRequest) -> ValidationResponse
    
    func validate(postRequest: PostRequest) -> ValidationResponse
}
