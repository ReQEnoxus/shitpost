//
//  AuthFormView.swift
//  Shitpost
//
//  Created by Enoxus on 11.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit
import AnimatedTextInput

struct FormViewConfiguration {
    
    let logoImageName: String
    let submitButtonTitle: String
    let secondaryButtonTitle: String?
    let inputs: [InputViewConfiguration]
}

struct InputViewConfiguration {
    
    let placeholder: String
    let name: String
    let type: AnimatedTextInput.AnimatedTextInputType
}

class AuthFormView: UIView {
    
    private class Appearance {
        
        static let verticalContentSpacing: CGFloat = 8
        static let loginButtonCornerRadius: CGFloat = 8
        static let loginButtonContentInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        static let contentOffset = 64
        
        static let centerVerticalOffset: CGFloat = 30
        
        static let defaultTimeInterval: TimeInterval = 0.25
    }
    
    weak var delegate: AuthFormViewDelegate?
    
    let configuration: FormViewConfiguration
    
    fileprivate var inputs: [(name: String, input: AnimatedTextInput)] = []
    
    init(configuration: FormViewConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Subviews
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
        label.textAlignment = .center
        label.font = Font.small
        label.numberOfLines = .zero
        
        return label
    }()
    
    lazy var spacer: UIView = {
        
        let view = UIView()
        return view
    }()
    
    lazy var primaryButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = Appearance.loginButtonCornerRadius
        button.contentEdgeInsets = Appearance.loginButtonContentInsets
        button.setTitle(configuration.submitButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(primaryButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var secondaryButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle(configuration.secondaryButtonTitle, for: .normal)
        
        button.addTarget(self, action: #selector(secondaryButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var memeImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: configuration.logoImageName)
        
        return imageView
    }()
    
    //MARK: - Setup
    fileprivate func setupViewHierarchy() {
        
        for inputConfiguration in configuration.inputs {
            makeInputField(config: inputConfiguration)
        }
        
        addSubview(mainScrollView)
        mainScrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(spacer)
        mainStackView.addArrangedSubview(memeImageView)
        for (_, input) in inputs {
            mainStackView.addArrangedSubview(input)
        }
        mainStackView.addArrangedSubview(primaryButton)
        if let _ = configuration.secondaryButtonTitle {
            mainStackView.addArrangedSubview(secondaryButton)
        }
        mainStackView.addArrangedSubview(errorLabel)
        
        errorLabel.isHidden = true
    }
    
    fileprivate func setupConstraints() {
        
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
        
        primaryButton.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        for (_, input) in inputs {
            input.snp.makeConstraints { make in
                make.width.equalToSuperview()
            }
        }
    }
    
    fileprivate func makeInputField(config: InputViewConfiguration) {
        
        let textField = AnimatedTextInput()
        textField.style = InputStyle.Auth.inputStyle
        textField.placeHolderText = config.placeholder
        textField.type = config.type
        
        inputs.append((name: config.name, input: textField))
    }
    
    func toggleErrorLabel(_ show: Bool) {
        UIView.animate(withDuration: Appearance.defaultTimeInterval) {
            self.errorLabel.isHidden = !show
        }
    }
    
    //MARK: - Target-Action
    
    fileprivate var fields: [String: String?] {
        get {
            var dict: [String: String?] = [:]
            
            for (key, value) in inputs {
                dict[key] = value.text
            }
            return dict
        }
    }
    @objc fileprivate func primaryButtonTapped() {
        delegate?.didTapPrimaryButton(fields: fields)
    }
    
    @objc fileprivate func secondaryButtonTapped() {
        delegate?.didTapSecondaryButton(fields: fields)
    }
    
    func fieldByName(_ name: String) -> AnimatedTextInput? {
        for (key, value) in inputs {
            if key == name {
                return value
            }
        }
        return nil
    }
}
