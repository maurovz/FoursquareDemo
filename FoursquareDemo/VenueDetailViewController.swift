//
//  VenueDetailViewController.swift
//  FoursquareDemo
//
//  Created by Mauricio Vasquez on 1/26/16.
//  Copyright © 2016 TestIO. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift


class VenueDetailViewController: UIViewController {
  @IBOutlet weak var venueImageView: UIImageView!
  @IBOutlet weak var venueTitleLabel: UILabel!
  @IBOutlet weak var venueDescriptionTextView: UITextView!
  @IBOutlet weak var favoriteButton: UIButton!
  
  var venueID = ""
  var venueTitle = ""
  var venueDetails : JSON = []
  var venueDescription = ""
  var imageData = NSData()
  let realm = try! Realm()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    venueTitleLabel.text = venueTitle
    loadVenueDetails()
  }
  
  // MARK: - API Call

  func loadVenueDetails() {
    let indicator = UIActivityIndicatorView(frame: CGRectMake(0,0, 50, 50)) as UIActivityIndicatorView
    indicator.center = self.view.center
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
    view.addSubview(indicator)
    indicator.startAnimating()
    
    Alamofire.request(.GET, "https://api.foursquare.com/v2/venues/" + venueID, parameters: ["client_id": "WWWCYGJMOHYK4I5J4KALM5SEM4CHN1OWIAHFS4R0I2Z41UUT", "client_secret" : "QVYYDK5ZL0LECH2O2N2G3EFGQSSOOFCZ1ZLDVHV2RMUMVUK3", "v" : "20160120"])
      .responseJSON { response in
        
        if let jsonObject = response.result.value {
          
          let json = JSON(jsonObject)
          
          let urlString = String(json["response"]["venue"]["bestPhoto"]["prefix"]) + "500x300" + String(json["response"]["venue"]["bestPhoto"]["suffix"])
          
          let url = NSURL(string: urlString)
          let data = NSData(contentsOfURL: url!)
          
          if (data != nil) {
            self.imageData = data!
            self.venueImageView.image = UIImage(data: data!)
          }
          
          if (json["response"]["venue"]["description"] != nil) {
            self.venueDescriptionTextView.text = String(json["response"]["venue"]["description"])
            self.venueDescription = String(json["response"]["venue"]["description"])
          }
          else {
            self.venueDescriptionTextView.text = "No description"
            self.venueDescription = "No description"
          }
          indicator.stopAnimating()
        }
    }
    
  }
  
  // MARK: - Actions
  
  @IBAction func favoriteAction(sender: AnyObject) {
    if ((realm.objects(Venue).filter("title == %@", venueTitle).first == nil)) {
      
      let venue = Venue()
      venue.title = self.venueTitle
      venue.id = self.venueID
      venue.venueDescription = self.venueDescription
      venue.photo = self.imageData
      
      try! realm.write {
        realm .add(venue)
        
      }
    }
    self.favoriteButton.enabled = false
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
