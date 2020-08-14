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
    }
    internal enum SignUp {
        static let signupButtonTitle = "Sign Up"
        static let emailTextFieldPlaceholder = "Enter email"
        static let passwordTextFieldPlaceholder = "Enter password"
    }
    internal enum Validation {
        static let emailIsBadlyFormatted = "Email is badly formatted"
        static let passwordIsTooShort = "Password should be 6 to 20 symbols"
        static let emailCannotBeEmpty = "Email cannot be empty"
        static let passwordCannotBeEmpty = "Password cannot be empty"
        static let incorrectCredentials = "Incorrect email or password"
        static let incorrectPost = "Post should be from 1 to 280 symbols"
    }
    internal enum Post {
        static let postTextFieldPlaceholder = "Enter your post"
        static let postButtonTitle = "Send"
        static let exitButtonTitle = "Exit"
        static let viewControllerName = "Posts"
    }
    internal enum User {
        static let viewControllerName = "User"
    }
}
