//
//  AuthFormViewDelegate.swift
//  Shitpost
//
//  Created by Enoxus on 11.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol AuthFormViewDelegate: AnyObject {
    
    func didTapPrimaryButton(fields: [String: String?])
    func didTapSecondaryButton(fields: [String: String?])
}
