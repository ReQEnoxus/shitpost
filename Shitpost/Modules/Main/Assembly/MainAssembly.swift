//
//  MainAssembly.swift
//  Shitpost
//
//  Created by Enoxus on 14.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class MainAssembly {
    
    class func configure() -> UIViewController {
        
        let view = MainViewController()
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        let authService = AuthService()
        
        view.interactor = interactor
        view.router = router
        router.base = view
        interactor.authService = authService
        interactor.presenter = presenter
        presenter.view = view
        
        return view
    }
}
