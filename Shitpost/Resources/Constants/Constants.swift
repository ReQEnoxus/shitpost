//
//  Constants.swift
//  Shitpost
//
//  Created by Enoxus on 13.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

internal enum Constants {
    internal enum Post {
        static let minCharacterCount = 1
        static let maxCharacterCount = 280
    }
    internal enum UserDefaults {
        internal enum Keys {
            static let isAuthenticated = "isAuthenticated"
        }
    }
}
