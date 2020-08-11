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
        if response.success, let user = response.user {
            print(user)
        }
        else {
            guard let error = response.error, let malformedCredential = response.malformedCredential else {
                if let error = response.error {
                    view.showInvalidCredentialsError(error)
                }
                return
            }
            switch malformedCredential {
            case .email:
                view.showEmailError(error)
            case .password:
                view.showPasswordError(error)
            }
        }
    }
}
