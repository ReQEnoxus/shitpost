//
//  PostsPresenter.swift
//  Shitpost
//
//  Created by Enoxus on 14.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class PostsPresenter: PostsPresenterInput {
    
    weak var view: PostsViewInput!
    
    func postingFinishedWithError(_ errors: [String : String]?) {
        
        guard let error = errors?[Identifier.Post.postInput] else { return }
        view.showPostingError(error)
    }
    
    func newPostsReceived(_ posts: [Post]) {
        
        let reversed = posts.reversed()
        var paths = [IndexPath]()
        
        for i in .zero ..< posts.count {
            paths.append(IndexPath(row: i, section: .zero))
        }
        
        view.receivedNewPosts(reversed.map({ PostViewModel(content: $0.content, authorEmail: $0.owner.email) }), paths: paths)
    }
    
    func postingFinishedWithSuccess() {
        view.postingFinishedWithSuccess()
    }
}
