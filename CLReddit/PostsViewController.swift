//
//  PostsViewController.swift
//  CLReddit
//
//  Created by Soaurabh Kakkar on 31/05/17.
//  Copyright © 2017 Soaurabh Kakkar. All rights reserved.
//

import UIKit

class PostsViewController: UITableViewController {
    var postStore: PostStore!
    var sortedPosts:[Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 70
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
    
    @IBAction func reloadTable(_ sender: UIBarButtonItem) {
        self.sortAndReloadTableView()
    }
    
    func sortAndReloadTableView()  {
        sortedPosts = postStore.sortedPosts
        tableView.reloadData()
    }
    
    func upvote(sender:UIButton) {
        
        let postID = sender.tag
        if let post = postStore.post(forPostID: postID) {
            post.votes += 1
            self.reloadTableViewRows(sender)
        }
        
    }
    
    func downvote(sender:UIButton) {
        
        let postID = sender.tag
        if let post = postStore.post(forPostID: postID) {
            post.votes -= 1
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


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case "addItem"?:
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
