//
//  PostCell.swift
//  CLReddit
//
//  Created by Soaurabh Kakkar on 31/05/17.
//  Copyright © 2017 Soaurabh Kakkar. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet var titleLabel:UILabel!
    @IBOutlet var votesLabel:UILabel!
    @IBOutlet var upvoteBtn: UIButton!
    @IBOutlet var downvoteBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
         //Listen for dynamic type change notification
        NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: nil, queue: .main) { [weak self] notification in
            self?.titleLabel.font = .preferredFont(forTextStyle: .body)
            self?.votesLabel.font = .preferredFont(forTextStyle: .footnote)
            self?.upvoteBtn.titleLabel!.font = .preferredFont(forTextStyle: .subheadline)
            self?.downvoteBtn.titleLabel!.font = .preferredFont(forTextStyle: .subheadline)
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIContentSizeCategoryDidChange, object: nil)
    }

}
