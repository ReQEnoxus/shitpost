//
//  ValidationErrorImpl.swift
//  Shitpost
//
//  Created by Enoxus on 11.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Validator

struct ValidationErrorImpl: ValidationError {
    var message: String
    
    init(message: String) {
        self.message = message
    }
}
