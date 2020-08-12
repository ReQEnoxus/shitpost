//
//  SignUpPresenter.swift
//  Shitpost
//
//  Created by Enoxus on 11.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class SignUpPresenter: SignUpPresenterInput {
    
    weak var view: SignUpViewInput!
    
    func signUpFinished(with response: SignUpResponse) {
        if response.success {
            print("OK")
        }
        else if let serverError = response.error {
            view.showInvalidCredentialsError(serverError)
        }
        else if let malformedFeilds = response.malformedFields {
            for (field, error) in malformedFeilds {
                view.showMalformedFieldError(field: field, error: error)
            }
        }
    }
}
