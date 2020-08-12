//
//  AuthRouterInput.swift
//  Shitpost
//
//  Created by Enoxus on 12.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol AuthRouterInput: AnyObject {
    
    func presentSignUpController()
    
    func pushMainModule()
}
