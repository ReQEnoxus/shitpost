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
        static let loginButtonCornerRadius: CGFloat = 8
        static let loginButtonContentInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        static let contentOffset = 64
        
        static let centerVerticalOffset: CGFloat = 30
        
        static let defaultTimeInterval: TimeInterval = 0.25
    }
    
    var interactor: AuthInteractorInput!
    
    //MARK: - Views
    lazy var mainScrollView: UIScrollView = {
        
        let scroll = UIScrollView()
        scroll.alwaysBounceVertical = false
        scroll.contentOffset = .zero
        return scroll
    }()
    
    lazy var mainStackView: UIStackView = {
        
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = Appearance.verticalContentSpacing
        
        return stack
    }()
    
    lazy var errorLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .systemRed
        label.text = Text.Auth.Error.incorrectCredentials
        label.textAlignment = .center
        label.font = Font.small
        label.numberOfLines = .zero
        
        return label
    }()
    
    lazy var spacer: UIView = {
        
        let view = UIView()
        return view
    }()
    
    lazy var emailTextField: AnimatedTextInput = {
        
        let textField = AnimatedTextInput()
        textField.style = InputStyle.Auth.inputStyle
        textField.placeHolderText = Text.Auth.emailTextFieldPlaceholder
        textField.type = .email
        
        return textField
    }()
    
    lazy var passwordTextField: AnimatedTextInput = {
        
        let textField = AnimatedTextInput()
        textField.style = InputStyle.Auth.inputStyle
        textField.placeHolderText = Text.Auth.passwordTextFieldPlaceholder
        textField.type = .password(toggleable: true)
        
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = Appearance.loginButtonCornerRadius
        button.contentEdgeInsets = Appearance.loginButtonContentInsets
        button.setTitle(Text.Auth.loginButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var signUpButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle(Text.Auth.signUpButtonTitle, for: .normal)
        
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var memeImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Image.Auth.penguin)
        
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(spacer)
        mainStackView.addArrangedSubview(memeImageView)
        mainStackView.addArrangedSubview(emailTextField)
        mainStackView.addArrangedSubview(passwordTextField)
        mainStackView.addArrangedSubview(loginButton)
        mainStackView.addArrangedSubview(signUpButton)
        mainStackView.addArrangedSubview(errorLabel)
        
        errorLabel.isHidden = true
        configureTransparentNavigationBar()
        
        setupHideKeyboardOnTap()
    }
    
    fileprivate func setupConstraints() {
        
        mainScrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints { make in
            
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(Appearance.contentOffset)
            make.right.equalToSuperview().inset(Appearance.contentOffset)
        }
        
        spacer.snp.makeConstraints { make in
            
            make.width.equalToSuperview()
            make.height.equalTo(Appearance.centerVerticalOffset)
        }
        
        memeImageView.snp.makeConstraints { make in
            
            make.width.equalToSuperview()
            make.height.equalTo(memeImageView.snp.width)
        }
        
        loginButton.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
    
    fileprivate func toggleErrorLabel(_ show: Bool) {
        UIView.animate(withDuration: Appearance.defaultTimeInterval) {
            self.errorLabel.isHidden = !show
        }
    }

    //MARK: - Target-Action
    @objc func loginButtonTapped() {
        toggleErrorLabel(false)
        interactor.login(with: LoginRequest(email: emailTextField.text, password: passwordTextField.text))
    }
    
    @objc func signUpButtonTapped() {
        print("signUpButtonTapped")
    }
}

extension AuthViewController: AuthViewInput {
    func showEmailError(_ error: String) {
        emailTextField.show(error: error)
    }
    
    func showPasswordError(_ error: String) {
        passwordTextField.show(error: error)
    }
    
    func showInvalidCredentialsError(_ error: String) {
        errorLabel.text = error
        toggleErrorLabel(true)
    }
}

//MARK: - Keyboard Observation
extension AuthViewController: KeyboardObservingControllerProtocol {
    
    fileprivate func adjustContentOffset(by amount: CGFloat) {
        mainScrollView.setContentOffset(.init(x: .zero, y: amount), animated: true)
    }
    
    fileprivate func resetContentOffset() {
        mainScrollView.setContentOffset(.zero, animated: true)
    }
    
    @objc internal func didReceiveKeyboardWillShowNotification(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        let bottomSpace = view.safeAreaLayoutGuide.layoutFrame.height - mainStackView.frame.origin.y - mainStackView.frame.height
        
        let shift = keyboardHeight - bottomSpace + Appearance.verticalContentSpacing

        adjustContentOffset(by: shift)
    }
    
    @objc internal func didReceiveKeyboardWillHideNotification(_ notification: Notification) {
        resetContentOffset()
    }
}

