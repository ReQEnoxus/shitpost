//
//  SignUpInteractor.swift
//  Shitpost
//
//  Created by Enoxus on 11.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class SignUpInteractor: SignUpInteractorInput {
    
    var authService: AuthServiceProtocol!
    var validationService: ValidationServiceProtocol!
    var presenter: SignUpPresenterInput!
    
    func signUp(with request: SignUpRequest) {
        let validationResponse = validationService.validate(signUpRequest: request)
        
        if validationResponse.isSuccessful, let email = request.email, let password = request.password {
            authService.signUp(email: email, password: password) { [weak self] result in
                switch result {
                case .failure(let error):
                    self?.presenter.signUpFinished(with: SignUpResponse(success: false, error: error.localizedDescription, malformedFields: nil))
                case .success(_):
                    self?.presenter.signUpFinished(with: SignUpResponse(success: true, error: nil, malformedFields: nil))
                }
            }
        }
        else {
            presenter.signUpFinished(with: SignUpResponse(success: false, error: nil, malformedFields: validationResponse.malformedFields))
        }
    }
}
