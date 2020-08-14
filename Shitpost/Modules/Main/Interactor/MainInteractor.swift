//
//  MainInteractor.swift
//  Shitpost
//
//  Created by Enoxus on 14.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class MainInteractor: MainInteractorInput {
    
    var authService: AuthServiceProtocol!
    var presenter: MainPresenterInput!
    
    func logOut() {
        authService.signOut { error in
            presenter.didFinishLoggingOut(with: error)
        }
    }
}
