//
//  AuthPresenterInput.swift
//  Shitpost
//
//  Created by Enoxus on 10.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol AuthPresenterInput: AnyObject {
    
    func loginFinished(with response: LoginResponse)
    func loginIsNotRequired()
}
