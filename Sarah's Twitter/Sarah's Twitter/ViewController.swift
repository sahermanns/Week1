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
  lazy var imageQueue = NSOperationQueue()
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.estimatedRowHeight = 70
    tableView.rowHeight = UITableViewAutomaticDimension
    
    tableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TweetCell")

    
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
    tableView.delegate = self
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

extension ViewController : UITableViewDataSource, UITableViewDelegate {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
    cell.tag++
    let tag = cell.tag
    var tweet = tweets[indexPath.row]
    cell.profileImage.image = nil
    cell.userName.text = tweet.userName
    cell.tweetText.text = tweet.text
  
    if let profileImage = tweet.profileImage {
      cell.profileImage.image = profileImage
    }else {
      imageQueue.addOperationWithBlock({ () -> Void in
        if let imageURL = NSURL(string: tweet.profileImageURL),
          imageData = NSData(contentsOfURL: imageURL),
          image = UIImage(data: imageData) {
            var size : CGSize
            switch UIScreen.mainScreen().scale {
            case 2:
              size = CGSize(width: 140, height: 140)
            case 3:
              size = CGSize(width: 210, height: 210)
            default:
              size = CGSize(width: 70, height: 70)

    }
          let resizedImage = ImageResizer.resizeImage(image, size: size)
          
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            tweet.profileImage = resizedImage
            self.tweets[indexPath.row] = tweet
            if cell.tag == tag {
              cell.profileImage.image = resizedImage
            }
          })
        }
      })
    }
    
    return cell
  }
  

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.performSegueWithIdentifier("selectTweet", sender: nil)
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


