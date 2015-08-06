//
//  ViewController.swift
//  Sarah's Twitter
//
//  Created by Sarah Hermanns on 8/3/15.
//  Copyright (c) 2015 SASH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var tweets = [Tweet]()
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.estimatedRowHeight = 70
    tableView.rowHeight = UITableViewAutomaticDimension

    
    LoginService.loginForTwitter { (errorDescription, account) -> (Void) in
      if let errorDescription = errorDescription {
        //        give user error message
      }
      if let account = account {
      TwitterService.sharedService.account = account
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          self.activityIndicator.startAnimating()
        })
        
        TwitterService.tweetsFromHomeTimeline( { (errorDescription, tweets) -> (Void) in
          if let tweets = tweets {
            NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
              self.tweets = tweets
              self.activityIndicator.stopAnimating()
              self.tableView.reloadData()
            }
          }
        })
      }
    }
    
    tableView.dataSource = self
    tableView.reloadData()
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateLabels", name: UIContentSizeCategoryDidChangeNotification, object: nil)
    
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
  }
  func updateLabels() {
    self.tableView.reloadData()
  }
}


//keeping tableview control separate from main view control

extension ViewController : UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
    let tweet = tweets[indexPath.row]
    cell.userName.text = tweet.userName
    cell.tweetText.text = tweet.text
//    cell.profileImage.text = tweet.profileImageURL
    
    
    return cell
  }
    
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "selectTweet" {
      let destinationVC = segue.destinationViewController as! TweetDetailViewController
      let indexPath = self.tableView.indexPathForSelectedRow()
      let tweet = self.tweets[indexPath!.row]
      
      destinationVC.selectedTweet = tweet
    }
  }
  

}


