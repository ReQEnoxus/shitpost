//
//  AuthInteractor.swift
//  Shitpost
//
//  Created by Enoxus on 10.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Firebase

class AuthInteractor: AuthInteractorInput {
    
    var presenter: AuthPresenterInput!
    var authService: AuthServiceProtocol!
    var validationService: ValidationServiceProtocol!
    
    func login(with request: LoginRequest) {
        
        let validationResponse = validationService.validate(loginRequest: request)
        
        if validationResponse.isSuccessful, let email = request.email, let password = request.password {
            authService.signIn(email: email, password: password) { [weak self] result in
                switch result {
                case .failure(let error):
                    self?.presenter.loginFinished(with: LoginResponse(success: false, error: error.localizedDescription, malformedFields: nil))
                case .success:
                    self?.presenter.loginFinished(with: LoginResponse(success: true, error: nil, malformedFields: nil))
                }
            }
        }
        else {
            presenter.loginFinished(with: LoginResponse(success: false, error: nil, malformedFields: validationResponse.malformedFields))
        }
    }
    
    func checkAuth() {
        let authenticated = UserDefaults.standard.bool(forKey: Constants.UserDefaults.Keys.isAuthenticated)
        
        if authenticated {
            presenter.loginIsNotRequired()
        }
    }
}
