//
//  SignUpAssembly.swift
//  Shitpost
//
//  Created by Enoxus on 11.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class SignUpAssembly {
    
    class func configure() -> UIViewController {
        
        let view = SignUpViewController()
        let interactor = SignUpInteractor()
        let presenter = SignUpPresenter()
        
        let validationService = ValidationService()
        let authService = AuthService()
        
        view.interactor = interactor
        interactor.authService = authService
        interactor.validationService = validationService
        interactor.presenter = presenter
        presenter.view = view
        
        return view
    }
}
