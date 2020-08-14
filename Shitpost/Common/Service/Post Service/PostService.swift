//
//  PostService.swift
//  Shitpost
//
//  Created by Enoxus on 14.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import Firebase

class PostService: PostServiceProtocol {
    
    var ref: DatabaseReference!
    
    init() {
        ref = Database.database().reference()
    }
    
    func observe(onNew callback: @escaping (Post) -> Void) {
        ref.observe(.childChanged) { snapshot in
            guard let dict = snapshot.value as? [String: String],
                let email = dict["email"], let content = dict["content"] else { return }
            
            let post = Post(key: snapshot.key, content: content, owner: User(email: email))
            
            DispatchQueue.main.async {
                callback(post)
            }
        }
    }
    
    func obtainAllPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        ref.child("posts").observeSingleEvent(of: .value) { snapshot in
            var posts = [Post]()
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                guard let dict = snap.value as? [String: String],
                    let email = dict["email"],
                    let content = dict["content"] else { return }
                
                let post = Post(key: snap.key, content: content, owner: User(email: email))
                posts.append(post)
            }
            
            DispatchQueue.main.async {
                completion(.success(posts.reversed()))
            }
        }
    }
    
    func addNewPost(post: Post) {
        ref.child("posts").childByAutoId().setValue([
            "email": post.owner.email,
            "content": post.content
        ])
    }
    
    
}
