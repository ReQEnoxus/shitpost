//
//  SignUpRouter.swift
//  Shitpost
//
//  Created by Enoxus on 14.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class SignUpRouter: Router, SignUpRouterInput {
    weak var base: UIViewController!
    
    func navigateToMainModule() {
        base.dismiss(animated: true) { [weak self] in
            self?.base.presentingViewController?.navigationController?.pushViewController(MainAssembly.configure(), animated: true)
        }
    }
    
}
