//
//  PostsViewController.swift
//  CLReddit
//
//  Created by Soaurabh Kakkar on 31/05/17.
//  Copyright © 2017 Soaurabh Kakkar. All rights reserved.
//

import UIKit

/// estimatedRowHeight is a constant representing tableView's estimatedRowHeight.
let estimatedRowHeight:CGFloat = 70

/// PostsViewController is a subclass of UITableViewController for configuring and managing the associated tableView i.e. initial view of the application.
class PostsViewController: UITableViewController {
    
    /// postStore is an instance property which holds a reference to a store object.
    var postStore: PostStore!
    
    /// sortedPosts is an instance property which holds all the Posts sorted by votes(decending) and title(ascending).
    var sortedPosts:[Post] = []
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting automatic/estimated row height for the tableView.
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = estimatedRowHeight
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Sort all the posts and reload table.
        self.sortAndReloadTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Reload tableView
    
    /// reloadTable(_ sender:) is reponsible for sorting all the tableView rows by votes(decending), title(ascending) and reloading them.
    ///
    /// - Parameter sender: UIBarButtonItem object which triggers this action.
    @IBAction func reloadTable(_ sender: UIBarButtonItem) {
        self.sortAndReloadTableView()
    }
    
    /// sortAndReloadTableView() is reponsible for sorting all the tableView rows by votes(decending), title(ascending) and reloading them.
    func sortAndReloadTableView()  {
        
        //Sorting the posts by votes and if two posts have same votes then sorting them by their titles.
        let votesSortDescriptor = NSSortDescriptor(key: "votes", ascending: false)
        let titleSortDescriptor = NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        
        sortedPosts = postStore.sortAllPosts([votesSortDescriptor, titleSortDescriptor])
        tableView.reloadData()
    }
    
    // MARK: - Upvote/Downvote
    
    /// upvote(sender:) is reponsible for incrementing votes by 1 for a given Post and reloads that tableView row to reflect changes.
    ///
    /// - Parameter sender: UIButton object which triggers this action.
    func upvote(sender:UIButton) {
        
        // find the post from sender's tag, increment votes and reload that row.
        let postID = sender.tag
        if let post = postStore.post(forPostID: postID) {
            post.upvote()
            self.reloadTableViewRow(sender)
        }
        
    }
    
    /// downvote(sender:) is reponsible for decrementing votes by 1 for a given Post and reloads that tableView row to reflect changes.
    ///
    /// - Parameter sender: UIButton object which triggers this action.
    func downvote(sender:UIButton) {
        
        // find the post from sender's tag, decrement votes and reload that row.
        let postID = sender.tag
        if let post = postStore.post(forPostID: postID) {
            post.downvote()
            self.reloadTableViewRow(sender)
        }
    }
    
    /// reloadTableViewRow(_ sender:) is reponsible for reloading a row on which button action is identified.
    ///
    /// - Parameter sender: UIButton object which triggers this action.
    func reloadTableViewRow(_ sender: UIButton)  {
        let position = sender.convert(CGPoint.zero, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: position)
        if let indexPath = indexPath {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the postStore object to addViewController.
        switch segue.identifier {
        case "addPost"?:
            let addViewController = segue.destination as! AddViewController
            addViewController.postStore = postStore
            
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    

}

// MARK: - Table view data source methods
extension PostsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // sortedPosts contains all the Post objects.
        return sortedPosts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        // Configure the reusable cell from post object...
        let post = sortedPosts[indexPath.row]
        
        cell.titleLabel.text = post.title
        cell.votesLabel.text = "\(post.votes) votes"
        
        // Tag upvoteBtn & downvoteBtn with postID to uniquely identify the associated Post.
        cell.upvoteBtn.tag = post.postID
        cell.upvoteBtn.addTarget(self, action: #selector(upvote(sender:)), for: UIControlEvents.touchUpInside)
        
        cell.downvoteBtn.tag = post.postID
        cell.downvoteBtn.addTarget(self, action: #selector(downvote(sender:)), for: UIControlEvents.touchUpInside)
        
        return cell
    }

}
