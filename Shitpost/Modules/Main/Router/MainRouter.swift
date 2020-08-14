//
//  MainRouter.swift
//  Shitpost
//
//  Created by Enoxus on 14.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class MainRouter: Router, MainRouterInput {
    
    weak var base: UIViewController!
    
    func exit() {
        pop(animated: false)
    }
}
