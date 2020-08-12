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
    
    func push(_ viewController: UIViewController)
    
    func present(_ viewController: UIViewController)
    
    func dismiss()
    
    func pop()
}

extension Router {
    
    func push(_ viewController: UIViewController) {
        base.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(_ viewController: UIViewController) {
        base.present(viewController, animated: true)
    }
    
    func dismiss() {
        base.dismiss(animated: true, completion: nil)
    }
    
    func pop() {
        base.navigationController?.popViewController(animated: true)
    }
}
