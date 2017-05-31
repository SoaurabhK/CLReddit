//
//  Post.swift
//  CLReddit
//
//  Created by Soaurabh Kakkar on 31/05/17.
//  Copyright © 2017 Soaurabh Kakkar. All rights reserved.
//

import UIKit

class Post: NSObject {
    private static var postCount: Int = 0
    public private(set) var postID: Int
    var title: String
    var votes: Int
    
    init(title: String) {
        Post.postCount += 1
        self.title = title
        self.votes = 1 //Post is initialized with +1 votes.
        self.postID = Post.postCount
    }
    
    convenience override init() {
        //Creating default posts by fruit names :)
        let postTitles = ["Apple", "Apricot", "Avocado", "Banana", "Blueberry", "Cherry", "Coconut", "Grape", "Guava", "Jackfruit", "Lemon",  "Mango", "Melon", "Olive", "Orange", "Papaya", "Plum", "Pineapple", "Raspberry", "Strawberry"]
        
        let index = arc4random_uniform(UInt32(postTitles.count))
        let randomTitle = postTitles[Int(index)]
        
        self.init(title: randomTitle)
    }
    
    
}
