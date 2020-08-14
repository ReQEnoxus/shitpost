//
//  ValidationService.swift
//  Shitpost
//
//  Created by Enoxus on 11.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Validator

class ValidationService: ValidationServiceProtocol {
    
    func validate(signUpRequest: SignUpRequest) -> ValidationResponse {
        return validateCredentials(email: signUpRequest.email, password: signUpRequest.password)
    }
    
    func validate(loginRequest: LoginRequest) -> ValidationResponse {
        return validateCredentials(email: loginRequest.email, password: loginRequest.password)
    }
    
    func validate(postRequest: PostRequest) -> ValidationResponse {
        
        let validationRule = ValidationRuleLength(min: Constants.Post.minCharacterCount, max: Constants.Post.maxCharacterCount, lengthType: .characters, error: ValidationErrorImpl(message: Text.Validation.incorrectPost))
        
        let validationResult = postRequest.content?.validate(rule: validationRule)
        
        guard let result = validationResult else {
            return ValidationResponse(isSuccessful: false, malformedFields: [Identifier.Post.postInput: Text.Validation.incorrectPost])
        }
        
        if !result.isValid {
            return ValidationResponse(isSuccessful: false, malformedFields: [Identifier.Post.postInput: Text.Validation.incorrectPost])
        }
        else {
            return ValidationResponse(isSuccessful: true, malformedFields: nil)
        }
    }
    
    fileprivate func validateCredentials(email: String?, password: String?) -> ValidationResponse {
        
        let emailRule = ValidationRulePattern(pattern: EmailValidationPattern.standard, error: ValidationErrorImpl(message: Text.Validation.emailIsBadlyFormatted))
        
        let passwordRule = ValidationRuleLength(min: 6, max: 20, lengthType: .characters, error: ValidationErrorImpl(message: Text.Validation.passwordIsTooShort))
        
        let emailValidation = email?.validate(rule: emailRule)
        
        let passwordValidation = password?.validate(rule: passwordRule)
        
        guard let emailValid = emailValidation, let passwordValid = passwordValidation else {
            return ValidationResponse(isSuccessful: false, malformedFields: [
                Identifier.Form.email: Text.Validation.emailIsBadlyFormatted,
                Identifier.Form.password: Text.Validation.passwordIsTooShort
            ])
        }
        
        if emailValid.isValid && passwordValid.isValid {
            return ValidationResponse(isSuccessful: true, malformedFields: nil)
        }
        
        var malformedFields: [String: String] = [:]
        
        if case .invalid(let errors) = emailValid {
            malformedFields[Identifier.Form.email] = errors[.zero].message
        }
        if case .invalid(let errors) = passwordValid {
            malformedFields[Identifier.Form.password] = errors[.zero].message
        }
        
        return ValidationResponse(isSuccessful: false, malformedFields: malformedFields)
    }
}
