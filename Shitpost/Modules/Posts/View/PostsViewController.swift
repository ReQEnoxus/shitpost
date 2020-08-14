//
//  PostsViewController.swift
//  Shitpost
//
//  Created by Enoxus on 13.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit
import AnimatedTextInput

class PostsViewController: UIViewController {
    
    private class Appearance {
        
        static let verticalContentSpacing: CGFloat = 8
        static let defaultContentOffset: CGFloat = 8
        static let buttonCornerRadius: CGFloat = 8
        
        static let initialHeaderHeight: CGFloat = 125
    }
    
    var interactor: PostsInteractorInput!
    
    fileprivate var previousInputHeight: CGFloat = .zero
    
    var viewModels: [PostViewModel] = []
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.dataSource = self
        
        return tableView
    }()
    
    lazy var containerView: UIView = UIView()
    
    lazy var postTextField: AnimatedTextInput = {
        
        let field = AnimatedTextInput()
        field.style = InputStyle.Auth.inputStyle
        field.type = .multiline
        field.showCharacterCounterLabel(with: Constants.Post.maxCharacterCount)
        field.placeHolderText = Text.Post.postTextFieldPlaceholder
        field.delegate = self
        
        return field
    }()
    
    lazy var sendButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle(Text.Post.postButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.contentEdgeInsets = .init(top: Appearance.defaultContentOffset, left: Appearance.defaultContentOffset, bottom: Appearance.defaultContentOffset, right: Appearance.defaultContentOffset)
        button.layer.cornerRadius = Appearance.buttonCornerRadius
        
        button.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.register(PostCell.self, forCellReuseIdentifier: Identifier.Cell.postCell)
        setupHideKeyboardOnTap()
        setupViewHierarchy()
        setupConstraints()
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        interactor.startObservingDatabase()
    }
    
    fileprivate func setupViewHierarchy() {
        
        containerView.addSubview(postTextField)
        containerView.addSubview(sendButton)
        containerView.frame = CGRect(x: .zero, y: .zero, width: tableView.frame.width, height: Appearance.initialHeaderHeight)
        view.addSubview(tableView)
        tableView.tableHeaderView = containerView
        containerView.setNeedsLayout()
        containerView.layoutIfNeeded()
        containerView.frame.size = containerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = containerView
    }
    
    fileprivate func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    
        postTextField.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(Appearance.defaultContentOffset)
            make.trailing.equalToSuperview().inset(Appearance.defaultContentOffset)
        }
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(postTextField.snp.bottom).offset(Appearance.defaultContentOffset)
            make.trailing.equalToSuperview().inset(Appearance.defaultContentOffset)
            make.bottom.equalToSuperview().inset(Appearance.defaultContentOffset)
        }
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - Target-Action
extension PostsViewController {
    
    @objc fileprivate func didTapSendButton() {
        interactor.createNewPost(from: PostRequest(content: postTextField.text))
    }
}

extension PostsViewController: PostsViewInput {
    func receivedNewPosts(_ posts: [PostViewModel], paths: [IndexPath]) {
        
        viewModels = posts + viewModels
        tableView.beginUpdates()
        tableView.insertRows(at: paths, with: .automatic)
        tableView.endUpdates()
    }
    
    func showPostingError(_ error: String) {
        postTextField.show(error: error)
    }
    
    func postingFinishedWithSuccess() {
        postTextField.text = String()
        postTextField.showCharacterCounterLabel(with: Constants.Post.maxCharacterCount)
    }
}

extension PostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.Cell.postCell, for: indexPath) as! PostCell
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
}

extension PostsViewController: AnimatedTextInputDelegate {

    func animatedTextInputDidChange(animatedTextInput: AnimatedTextInput) {
        
        let height = animatedTextInput.frame.size.height
        if height != previousInputHeight {
            containerView.frame.size = containerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            tableView.tableHeaderView = containerView
            previousInputHeight = height
        }

        if let text = animatedTextInput.text, text.count > Constants.Post.maxCharacterCount {
            animatedTextInput.text = String(text.prefix(Constants.Post.maxCharacterCount))
            animatedTextInput.showCharacterCounterLabel(with: Constants.Post.maxCharacterCount)
        }
    }
}
