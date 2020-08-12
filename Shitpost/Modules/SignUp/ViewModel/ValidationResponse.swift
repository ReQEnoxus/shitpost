//
//  ValidationResponse.swift
//  Shitpost
//
//  Created by Enoxus on 11.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

struct ValidationResponse {
    let isSuccessful: Bool
    let malformedFields: [String: String]?
}
