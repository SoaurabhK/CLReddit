//
//  PostStore.swift
//  CLReddit
//
//  Created by Soaurabh Kakkar on 31/05/17.
//  Copyright © 2017 Soaurabh Kakkar. All rights reserved.
//

import Foundation

class PostStore {
    var allPosts: [Post] = []
    
    init() {
        for _ in 0..<20 {
            allPosts.append(Post())
        }
        self.sortAllPosts()
    }
    
    @discardableResult func createPost(title: String) -> Post {
        
        let post = Post(title: title)
        allPosts.append(post)
        
        return post
    }

}

extension PostStore {
    
    func sortAllPosts() {
        
        //Sorting the posts by votes and if two posts have same votes then sorting them by their titles.
        let votesSortDescriptor = NSSortDescriptor(key: "votes", ascending: false)
        let titleSortDescriptor = NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        
        //Force casting the result back to [Post] because we are sure about type here.
        self.allPosts = (self.allPosts as NSArray).sortedArray(using: [votesSortDescriptor, titleSortDescriptor]) as! [Post]
        
    }

}
