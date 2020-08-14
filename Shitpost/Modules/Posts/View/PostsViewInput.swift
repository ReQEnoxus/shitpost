//
//  PostsViewInput.swift
//  Shitpost
//
//  Created by Enoxus on 14.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol PostsViewInput: AnyObject {
    
    func receivedNewPosts(_ posts: [PostViewModel], paths: [IndexPath])
    
    func postingFinishedWithSuccess()
    
    func showPostingError(_ error: String)
}
