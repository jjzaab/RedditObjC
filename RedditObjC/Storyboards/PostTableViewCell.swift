//
//  PostTableViewCell.swift
//  RedditObjC
//
//  Created by XMS_JZhan on 2/12/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var upsCountLabel: UILabel!
    @IBOutlet weak var countCommentLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    // MARK: - Properties
    
    var post: DVMPost? {
        didSet {
            updateViews()
        }
    }
    var thumbnail: UIImage? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let post = post else { return }
        titleLabel.text = post.title;
        upsCountLabel.text = "\(post.ups) ↑"
        countCommentLabel.text = "\(post.commentCount) 📝"
        thumbnailImageView.image = thumbnail
    }

}
