//
//  PostsAssembly.swift
//  Shitpost
//
//  Created by Enoxus on 14.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class PostsAssembly {
    
    class func configure() -> UIViewController {
        
        let view = PostsViewController()
        let interactor = PostsInteractor()
        let presenter = PostsPresenter()
        let validationService = ValidationService()
        let postService = PostService()
        let userService = UserService()
        
        view.interactor = interactor
        interactor.presenter = presenter
        interactor.postService = postService
        interactor.userService = userService
        interactor.validationService = validationService
        presenter.view = view
        
        return view
    }
}
