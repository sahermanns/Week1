//
//  userTimelineViewController.swift
//  Sarah's Twitter
//
//  Created by Sarah Hermanns on 8/7/15.
//  Copyright (c) 2015 SASH. All rights reserved.
//

import UIKit

class userTimelineViewController: UIViewController {
  
  var tweets = [Tweet]()
  lazy var imageQueue = NSOperationQueue()
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var backgroundImage: UIImageView!
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var userName: UILabel!
  @IBOutlet weak var userLocation: UILabel!
  
  var selectedTweet = Tweet(text: "blahhh", userName: "Dum", screenName: "dork", location: "nowhere", id: "383838", profileImageURL: "lookatme", originalText: "Dummer", originalUserName: "blahblah", originalQuote: "shut up", originalQUserName: "dummerer", profileImage: nil, backgroundImageURL: nil, backgroundImage: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
      
      title = self.selectedTweet.userName
      userName.text = self.selectedTweet.userName
      profileImage.image = self.selectedTweet.profileImage
      userLocation.text = self.selectedTweet.location
      backgroundImage.image = self.selectedTweet.backgroundImage
      

      tableView.estimatedRowHeight = 70
      tableView.rowHeight = UITableViewAutomaticDimension
      
      tableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TweetCell")
      
      TwitterService.tweetsFromUserTimeline(selectedTweet.screenName, completionHandler: { (errorDescription, tweets) -> (Void) in
        if let tweets = tweets {
          NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.tweets = tweets
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
          }
        }
      })

      tableView.dataSource = self
      tableView.reloadData()
      
      NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateLabels", name: UIContentSizeCategoryDidChangeNotification, object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}

extension userTimelineViewController : UITableViewDataSource, UITableViewDelegate {
  
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
  
//        if let backgroundImage = selectedTweet.backgroundImage {
//          backgroundImage.UIImage = backgroundImage
//        }else {
//          imageQueue.addOperationWithBlock({ () -> Void in
//            if let imageURL = NSURL(string: self.selectedTweet.backgroundImageURL!),
//              imageData = NSData(contentsOfURL: imageURL),
//              image = UIImage(data: imageData) {
//                var size : CGSize
//                switch UIScreen.mainScreen().scale {
//                case 2:
//                  size = CGSize(width: 140, height: 140)
//                case 3:
//                  size = CGSize(width: 210, height: 210)
//                default:
//                  size = CGSize(width: 70, height: 70)
//  
//                }
//                let resizedImage = ImageResizer.resizeImage(image, size: size)
//  
//                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//                  self.selectedTweet.backgroundImage = resizedImage
//                  self.tweets[indexPath.row] = tweet
//                 
//                  let resizedImage = self.backgroundImage.image
//                })
//            }
//          })
//        }

    return cell
  }
}

