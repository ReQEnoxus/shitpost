//
//  PostCell.swift
//  Shitpost
//
//  Created by Enoxus on 13.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    private class Appearance {
        static let verticalSpacing: CGFloat = 8
        static let imageSide = 50
        static let defaultContentOffset = 8
    }
    
    var post: PostViewModel!
    
    lazy var mainStackView: UIStackView = {
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Appearance.verticalSpacing
        
        return stack
    }()
    
    lazy var contentLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = .zero
        label.textColor = .systemGray
        
        return label
    }()
    
    lazy var userAviImageView: UIImageView = {
        
        let imageView = UIImageView(frame: .init(x: .zero, y: .zero, width: Appearance.imageSide, height: Appearance.imageSide))
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.image = UIImage(named: Image.Post.avatar)
        
        return imageView
    }()
    
    lazy var userNameLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        
        return label
    }()
    
    lazy var containerView: UIView = {
        
        let view = UIView()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with post: PostViewModel) {
        
        self.post = post
        userNameLabel.text = post.authorEmail
        contentLabel.text = post.content
        userAviImageView.layer.cornerRadius = userAviImageView.frame.height / 2
    }
    
    fileprivate func setupViewHierarchy() {
        
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(containerView)
        containerView.addSubview(userAviImageView)
        containerView.addSubview(userNameLabel)
        mainStackView.addArrangedSubview(contentLabel)
    }
    
    fileprivate func setupConstraints() {
        
        mainStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Appearance.defaultContentOffset)
            make.top.equalToSuperview().offset(Appearance.defaultContentOffset)
            make.trailing.equalToSuperview().inset(Appearance.defaultContentOffset)
            make.bottom.equalToSuperview().inset(Appearance.defaultContentOffset)
        }
        userAviImageView.snp.makeConstraints { make in
            make.width.equalTo(Appearance.imageSide)
            make.height.equalTo(Appearance.imageSide)
            make.top.equalToSuperview().offset(Appearance.defaultContentOffset)
            make.bottom.equalToSuperview().inset(Appearance.defaultContentOffset)
            make.leading.equalToSuperview().offset(Appearance.defaultContentOffset)
        }
        userNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(userAviImageView.snp.trailing).offset(Appearance.defaultContentOffset)
            make.trailing.equalToSuperview().offset(Appearance.defaultContentOffset)
            make.centerY.equalTo(userAviImageView.snp.centerY)
        }
        containerView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
}
