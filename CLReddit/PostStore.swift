//
//  PostStore.swift
//  CLReddit
//
//  Created by Soaurabh Kakkar on 31/05/17.
//  Copyright © 2017 Soaurabh Kakkar. All rights reserved.
//

import Foundation

class PostStore {
    fileprivate var allPostsWithIDs: [Int: Post] = [:]
    
    init() {
        for _ in 0..<20 {
            let post = Post()
            allPostsWithIDs[post.postID] = post
        }
    }
    
    func post(forPostID postID: Int) -> Post? {
        
        return allPostsWithIDs[postID]
    }
    
    @discardableResult func createPost(title: String) -> Post {
        
        let post = Post(title: title)
        allPostsWithIDs[post.postID] = post
    
        return post
    }

}

extension PostStore {
    
    func sortAllPosts(_ sortDescriptors: [NSSortDescriptor]) -> Array<Post> {
        
        //Force casting the result back to [Post] because we are sure about type here.
        return (Array(self.allPostsWithIDs.values) as NSArray).sortedArray(using: sortDescriptors) as! [Post]
        
    }

}
