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
    var sortedPosts: [Post] {
        return sortAllPosts()
    }
    
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
    
    func sortAllPosts() -> Array<Post> {
        
        //Sorting the posts by votes and if two posts have same votes then sorting them by their titles.
        let votesSortDescriptor = NSSortDescriptor(key: "votes", ascending: false)
        let titleSortDescriptor = NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        
        //Force casting the result back to [Post] because we are sure about type here.
        return (Array(self.allPostsWithIDs.values) as NSArray).sortedArray(using: [votesSortDescriptor, titleSortDescriptor]) as! [Post]
        
    }

}
