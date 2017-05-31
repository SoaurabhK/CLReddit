//
//  PostsViewController.swift
//  CLReddit
//
//  Created by Soaurabh Kakkar on 31/05/17.
//  Copyright © 2017 Soaurabh Kakkar. All rights reserved.
//

import UIKit

let estimatedRowHeight:CGFloat = 70

class PostsViewController: UITableViewController {
    var postStore: PostStore!
    var sortedPosts:[Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = estimatedRowHeight
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Sort all the posts and reload table
        self.sortAndReloadTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Reload tableView
    @IBAction func reloadTable(_ sender: UIBarButtonItem) {
        self.sortAndReloadTableView()
    }
    
    func sortAndReloadTableView()  {
        
        //Sorting the posts by votes and if two posts have same votes then sorting them by their titles.
        let votesSortDescriptor = NSSortDescriptor(key: "votes", ascending: false)
        let titleSortDescriptor = NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        
        sortedPosts = postStore.sortAllPosts([votesSortDescriptor, titleSortDescriptor])
        tableView.reloadData()
    }
    
    // MARK: - Upvote/Downvote
    func upvote(sender:UIButton) {
        
        let postID = sender.tag
        if let post = postStore.post(forPostID: postID) {
            post.upvote()
            self.reloadTableViewRows(sender)
        }
        
    }
    
    func downvote(sender:UIButton) {
        
        let postID = sender.tag
        if let post = postStore.post(forPostID: postID) {
            post.downvote()
            self.reloadTableViewRows(sender)
        }
    }
    
    func reloadTableViewRows(_ sender: UIButton)  {
        let position = sender.convert(CGPoint.zero, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: position)
        if let indexPath = indexPath {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }


    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case "addPost"?:
            let addViewController = segue.destination as! AddViewController
            addViewController.postStore = postStore
            
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    

}

// MARK: - Table view data source
extension PostsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sortedPosts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        // Configure the cell...
        let post = sortedPosts[indexPath.row]
        
        cell.titleLabel.text = post.title
        cell.votesLabel.text = "\(post.votes) votes"
        
        cell.upvoteBtn.tag = post.postID
        cell.upvoteBtn.addTarget(self, action: #selector(upvote(sender:)), for: UIControlEvents.touchUpInside)
        
        cell.downvoteBtn.tag = post.postID
        cell.downvoteBtn.addTarget(self, action: #selector(downvote(sender:)), for: UIControlEvents.touchUpInside)
        
        return cell
    }

}
