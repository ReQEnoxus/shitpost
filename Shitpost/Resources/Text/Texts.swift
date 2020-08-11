//
//  Texts.swift
//  Shitpost
//
//  Created by Enoxus on 10.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

internal enum Text {
    internal enum Auth {
        static let loginButtonTitle = "Login"
        static let signUpButtonTitle = "Create Account"
        static let emailTextFieldPlaceholder = "Enter email"
        static let passwordTextFieldPlaceholder = "Enter password"
        
        internal enum Error {
            static let emailCannotBeEmpty = "Email cannot be empty"
            static let passwordCannotBeEmpty = "Password cannot be empty"
            static let incorrectCredentials = "Incorrect email or password"
        }
    }
}
