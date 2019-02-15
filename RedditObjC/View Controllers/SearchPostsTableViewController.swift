//
//  SearchPostsTableViewController.swift
//  RedditObjC
//
//  Created by XMS_JZhan on 2/12/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

import UIKit

class SearchPostsTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    var posts: [DVMPost] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        let post = posts[indexPath.row]
        cell.post = post
        
        DVMPostController.shared().fetchThumbnail(post) { (image) in
            DispatchQueue.main.async {
                cell.thumbnail = image
            }
        }
        
        return cell
    }
    
    // MARK: - delegates
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        DVMPostController.shared().searchForPost(withSearchTerm: searchText) { (posts, error) in
            if !(error != nil) {
                // Fill the posts that come back from the JSON and set them to our local array to populate table view controller
                self.posts = posts
                DispatchQueue.main.async {
                    self.title = searchText
                }
            }
        }
    }
    
}
