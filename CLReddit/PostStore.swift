//
//  PostStore.swift
//  CLReddit
//
//  Created by Soaurabh Kakkar on 31/05/17.
//  Copyright © 2017 Soaurabh Kakkar. All rights reserved.
//

import Foundation

/// PostStore class is an in-memory Store for holding all the Posts created by a user.
class PostStore {
    
    /// allPostsWithIDs is a fileprivate instance property of dictionary type where postID is stored as key and associated Post as value.
    fileprivate var allPostsWithIDs: [Int: Post] = [:]
    
    /// init() is a designated initializer of the class responsible for initializing store with 20 posts with random titles(fruit names).
    init() {
        for _ in 0..<20 {
            let post = Post()
            allPostsWithIDs[post.postID] = post
        }
    }
    
    /// post(forPostID postID:) returns the Post object for a given postID.
    ///
    /// - Parameter postID: Int value which uniquely identifies a Post.
    /// - Returns: Optional Post object.
    func post(forPostID postID: Int) -> Post? {
        
        return allPostsWithIDs[postID]
    }
    
    /// createPost(title:) creates a Post object with a given title and returns it.
    ///
    /// - Parameter title: title of the Post.
    /// - Returns: newly created Post object.
    @discardableResult func createPost(title: String) -> Post {
        
        let post = Post(title: title)
        allPostsWithIDs[post.postID] = post
    
        return post
    }

}

// MARK: - Sorting Posts
extension PostStore {
    
    /// sortAllPosts(_ sortDescriptors:) takes sortDescriptors Array as input and returns an Array of all the Posts sorted using input sortDescriptors.
    ///
    /// - Parameter sortDescriptors: Array of sortDescriptors.
    /// - Returns: Array of all the Posts sorted using sortDescriptors.
    func sortAllPosts(_ sortDescriptors: [NSSortDescriptor]) -> Array<Post> {
        
        //Force casting the result back to [Post] because we are sure about type here.
        return (Array(self.allPostsWithIDs.values) as NSArray).sortedArray(using: sortDescriptors) as! [Post]
        
    }

}
