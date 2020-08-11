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
    
    func login(with request: LoginRequest) {
        let response: LoginResponse
        
        guard let email = request.email, !email.isEmpty else {
            response = LoginResponse(user: nil, success: false, error: Text.Auth.Error.emailCannotBeEmpty, malformedCredential: .email)
            presenter.loginFinished(with: response)
            return
        }
        guard let password = request.password, !password.isEmpty else {
            response = LoginResponse(user: nil, success: false, error: Text.Auth.Error.passwordCannotBeEmpty, malformedCredential: .password)
            presenter.loginFinished(with: response)
            return
        }
        
        authService.signIn(email: email, password: password) { [weak self] result in
            switch result {
            case let .failure(error):
                self?.presenter.loginFinished(with: LoginResponse(user: nil, success: false, error: error.localizedDescription, malformedCredential: nil))
            case let .success(user):
                self?.presenter.loginFinished(with: LoginResponse(user: UserViewModel(email: user.email), success: true, error: nil, malformedCredential: nil))
            }
        }
    }
}
