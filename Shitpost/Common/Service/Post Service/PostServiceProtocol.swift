//
//  PostServiceProtocol.swift
//  Shitpost
//
//  Created by Enoxus on 14.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol PostServiceProtocol: AnyObject {
    
    func obtainAllPosts(completion: @escaping (Result<[Post], Error>) -> Void)
    
    func addNewPost(post: Post)
    
    func observe(onNew callback: @escaping (Post) -> Void)
}
