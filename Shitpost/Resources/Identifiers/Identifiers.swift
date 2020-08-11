//
//  Identifiers.swift
//  Shitpost
//
//  Created by Enoxus on 11.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

internal enum Identifier {
    internal enum Form {
        internal enum Auth {
            static let password = "auth_password"
            static let email = "auth_email"
        }
        internal enum Signup {
            static let email = "signup_email"
            static let password = "signup_password"
        }
    }
}
