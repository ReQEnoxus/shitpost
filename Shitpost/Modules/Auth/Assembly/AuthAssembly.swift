//
//  AuthAssembly.swift
//  Shitpost
//
//  Created by Enoxus on 11.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class AuthAssembly {
    class func configure() -> UIViewController {
        let view = AuthViewController()
        let interactor = AuthInteractor()
        let presenter = AuthPresenter()
        let authService = AuthService()
        
        view.interactor = interactor
        interactor.presenter = presenter
        interactor.authService = authService
        presenter.view = view
        
        return view
    }
}
