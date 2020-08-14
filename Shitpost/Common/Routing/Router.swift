//
//  Router.swift
//  Shitpost
//
//  Created by Enoxus on 12.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

protocol Router: AnyObject {
    
    var base: UIViewController! { get }
    
    func push(_ viewController: UIViewController, animated: Bool)
    
    func present(_ viewController: UIViewController, animated: Bool)
    
    func dismiss(animated: Bool)
    
    func pop(animated: Bool)
}

extension Router {
    
    func push(_ viewController: UIViewController, animated: Bool) {
        base.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func present(_ viewController: UIViewController, animated: Bool) {
        base.present(viewController, animated: animated)
    }
    
    func dismiss(animated: Bool) {
        base.dismiss(animated: animated, completion: nil)
    }
    
    func pop(animated: Bool) {
        base.navigationController?.popViewController(animated: animated)
    }
}
