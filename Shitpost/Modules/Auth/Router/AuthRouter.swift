//
//  AuthRouter.swift
//  Shitpost
//
//  Created by Enoxus on 12.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class AuthRouter: Router, AuthRouterInput {
    
    weak var base: UIViewController!
    
    func presentSignUpController() {
        present(SignUpAssembly.configure(), animated: true)
    }
    
    func pushMainModule(animated: Bool) {
        push(MainAssembly.configure(), animated: animated)
    }
    
    
}
