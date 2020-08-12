//
//  LoginResponse.swift
//  Shitpost
//
//  Created by Enoxus on 10.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation


struct LoginResponse {
    let success: Bool
    let error: String?
    let malformedFields: [String: String]?
}
