//
//  AuthPresenter.swift
//  Shitpost
//
//  Created by Enoxus on 10.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class AuthPresenter: AuthPresenterInput {
    
    weak var view: AuthViewInput!
    
    func loginFinished(with response: LoginResponse) {
        if response.success {
            view.loginFinishedWithSuccess()
        }
        else if let serverError = response.error {
            view.showInvalidCredentialsError(serverError)
        }
        else if let malformedFields = response.malformedFields {
            for (field, error) in malformedFields {
                view.showMalformedFieldError(field: field, error: error)
            }
        }
    }
    
    func loginIsNotRequired() {
        view.skipToMainModule()
    }
}
