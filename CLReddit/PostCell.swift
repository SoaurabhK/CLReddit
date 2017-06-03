//
//  PostCell.swift
//  CLReddit
//
//  Created by Soaurabh Kakkar on 31/05/17.
//  Copyright © 2017 Soaurabh Kakkar. All rights reserved.
//

import UIKit

/// PostCell is a subclass of UITableViewCell for configuring tableView's cell objects.
class PostCell: UITableViewCell {

    /// titleLabel is an outlet for a UILabel to show title of the Post.
    @IBOutlet var titleLabel: UILabel!
    
    /// votesLabel is an outlet for a UILabel to show votes for a Post.
    @IBOutlet var votesLabel: UILabel!
    
    /// upvoteBtn is an outlet for a UIButton which increments votes by 1.
    @IBOutlet var upvoteBtn: UIButton!
    
    /// downvoteBtn is an outlet for a UIButton which decrements votes by 1.
    @IBOutlet var downvoteBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
         //Listen for dynamic type change notification to adjust fonts based on change in device's accessibility settings.
        NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: nil, queue: .main) { [weak self] notification in
            self?.titleLabel.font = .preferredFont(forTextStyle: .body)
            self?.votesLabel.font = .preferredFont(forTextStyle: .footnote)
            self?.upvoteBtn.titleLabel!.font = .preferredFont(forTextStyle: .subheadline)
            self?.downvoteBtn.titleLabel!.font = .preferredFont(forTextStyle: .subheadline)
        }
    }

    deinit {
        
        //Remove self from observing dynamic type change notification.
        NotificationCenter.default.removeObserver(self, name: .UIContentSizeCategoryDidChange, object: nil)
    }

}
