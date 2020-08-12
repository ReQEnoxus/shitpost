//
//  ViewController.swift
//  Shitpost
//
//  Created by Enoxus on 10.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit
import SnapKit
import AnimatedTextInput

class AuthViewController: UIViewController {
    
    private class Appearance {
        static let verticalContentSpacing: CGFloat = 8
    }
    
    var interactor: AuthInteractorInput!
    var router: AuthRouterInput!
    
    var mainView: AuthFormView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let config = FormViewConfiguration(logoImageName: Image.Auth.penguin,
                                           submitButtonTitle: Text.Auth.loginButtonTitle,
                                           secondaryButtonTitle: Text.Auth.signUpButtonTitle,
                                           inputs: [
                                            InputViewConfiguration(placeholder: Text.Auth.emailTextFieldPlaceholder, name: Identifier.Form.email, type: .email),
                                            InputViewConfiguration(placeholder: Text.Auth.passwordTextFieldPlaceholder, name: Identifier.Form.password, type: .password(toggleable: true))
        ])
        let formView = AuthFormView(configuration: config)
        formView.delegate = self
        mainView = formView
        
        setupViewHierarchy()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopObservingKeyboardNotifications()
    }
    
    //MARK: - Setup
    fileprivate func setupViewHierarchy() {
        
        edgesForExtendedLayout = .top
        extendedLayoutIncludesOpaqueBars = false
        
        view.addSubview(mainView)
        
        configureTransparentNavigationBar()
        
        setupHideKeyboardOnTap()
    }
    
    fileprivate func setupConstraints() {
        
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension AuthViewController: AuthFormViewDelegate {
    func didTapPrimaryButton(fields: [String : String?]) {
        let email = fields[Identifier.Form.email]!
        let password = fields[Identifier.Form.password]!
        interactor.login(with: LoginRequest(email: email, password: password))
    }
    
    func didTapSecondaryButton(fields: [String : String?]) {
        router.presentSignUpController()
    }
}

extension AuthViewController: AuthViewInput {
    
    func showMalformedFieldError(field: String, error: String) {
        mainView.fieldByName(field)?.show(error: error)
    }
    
    func showInvalidCredentialsError(_ error: String) {
        mainView.errorLabel.text = error
        mainView.toggleErrorLabel(true)
    }
    
    func loginFinishedWithSuccess() {
        router.pushMainModule()
    }
}

//MARK: - Keyboard Observation
extension AuthViewController: KeyboardObservingControllerProtocol {
    
    fileprivate func adjustContentOffset(by amount: CGFloat) {
        mainView.mainScrollView.setContentOffset(.init(x: .zero, y: amount), animated: true)
    }
    
    fileprivate func resetContentOffset() {
        mainView.mainScrollView.setContentOffset(.zero, animated: true)
    }
    
    @objc internal func didReceiveKeyboardWillShowNotification(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        let bottomSpace = view.safeAreaLayoutGuide.layoutFrame.height - mainView.mainStackView.frame.origin.y - mainView.mainStackView.frame.height
        
        let shift = keyboardHeight - bottomSpace + Appearance.verticalContentSpacing
        
        adjustContentOffset(by: shift)
    }
    
    @objc internal func didReceiveKeyboardWillHideNotification(_ notification: Notification) {
        resetContentOffset()
    }
}

