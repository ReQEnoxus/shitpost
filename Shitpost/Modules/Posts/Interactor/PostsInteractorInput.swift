//
//  PostsInteractorInput.swift
//  Shitpost
//
//  Created by Enoxus on 14.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol PostsInteractorInput: AnyObject {
    
    func createNewPost(from request: PostRequest)
    
    func startObservingDatabase()
}
