//
//  PostsPresenterInput.swift
//  Shitpost
//
//  Created by Enoxus on 14.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol PostsPresenterInput: AnyObject {
    
    func postingFinishedWithError(_ errors: [String: String]?)
    
    func postingFinishedWithSuccess()
    
    func newPostsReceived(_ posts: [Post])
}
