//
//  PostsInteractor.swift
//  Shitpost
//
//  Created by Enoxus on 14.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class PostsInteractor: PostsInteractorInput {
    
    var validationService: ValidationServiceProtocol!
    var postService: PostServiceProtocol!
    var userService: UserServiceProtocol!
    
    var presenter: PostsPresenterInput!
    
    func createNewPost(from request: PostRequest) {
        let validationResult = validationService.validate(postRequest: request)
        if !validationResult.isSuccessful {
            presenter.postingFinishedWithError(validationResult.malformedFields)
        }
        else {
            
            guard let content = request.content, let user = userService.currentUser else { return }
            postService.addNewPost(post: Post(content: content, owner: user))
            presenter.postingFinishedWithSuccess()
        }
    }
    
    func startObservingDatabase() {
        postService.observe { [weak self] post in
            self?.presenter.newPostsReceived([post])
        }
    }
}
