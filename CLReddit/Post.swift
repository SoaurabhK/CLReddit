//
//  Post.swift
//  CLReddit
//
//  Created by Soaurabh Kakkar on 31/05/17.
//  Copyright © 2017 Soaurabh Kakkar. All rights reserved.
//

import UIKit

/// Post is a Model class for creating objects of type Post.
class Post: NSObject {
    
    /// postCount is a private static property to hold count of Post objects.
    private static var postCount: Int = 0
    
    /// postID is a readOnly instance property to uniquely identify a Post.
    public private(set) var postID: Int
    
    /// title is a readOnly instance property to hold title of the Post.
    public private(set) var title: String
    
    /// votes is a readOnly instance property to hold number of votes for a Post, it's initial default value is 1.
    public private(set) var votes: Int
    
    
    /// init(title:) is a designated initializer of the class responsible for initializing a Post with a given title, sets value of postID and a default value for votes.
    ///
    /// - Parameter title: String representing title of the Post
    init(title: String) {
        Post.postCount += 1
        self.title = title
        self.votes = 1 //Post is initialized with +1 votes.
        self.postID = Post.postCount
    }
    
    /// init() is a convenience initializer of the class responsible for initializing a Post with random Post titles, sets value of postID and a default value for votes.
    convenience override init() {
        //Creating default posts by fruit names :)
        let postTitles = ["Apple", "Apricot", "Avocado", "Banana", "Blueberry", "Cherry", "Coconut", "Grape", "Guava", "Jackfruit", "Lemon",  "Mango", "Melon", "Olive", "Orange", "Papaya", "Plum", "Pineapple", "Raspberry", "Strawberry"]
        
        let index = arc4random_uniform(UInt32(postTitles.count))
        let randomTitle = postTitles[Int(index)]
        
        self.init(title: randomTitle)
    }
    
    //MARK: - Upvote and Downvote

    /// upvote() is responsible for incrementing votes value by 1.
    func upvote() {
        self.votes += 1
    }
    
    /// downvote() is responsible for decrementing votes value by 1.
    func downvote() {
        self.votes -= 1
    }
    
}
