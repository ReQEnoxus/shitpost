//
//  LoginResponse.swift
//  Shitpost
//
//  Created by Enoxus on 10.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

enum Credential {
    case email
    case password
}

struct LoginResponse {
    let user: UserViewModel?
    let success: Bool
    let error: String?
    let malformedCredential: Credential?
}
