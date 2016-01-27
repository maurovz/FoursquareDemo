//
//  FavoriteDetailViewController.swift
//  FoursquareDemo
//
//  Created by Mauricio Vasquez on 1/27/16.
//  Copyright © 2016 TestIO. All rights reserved.
//

import UIKit

class FavoriteDetailViewController: UIViewController {
  @IBOutlet weak var venueTitleLabel: UILabel!
  @IBOutlet weak var venueImageView: UIImageView!
  @IBOutlet weak var venueDescriptionTextView: UITextView!
  
  var venueTitle = ""
  var venueDescription = ""
  var venueImageData = NSData()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    venueTitleLabel.text = venueTitle
    venueDescriptionTextView.text = venueDescription
    venueImageView.image = UIImage(data: self.venueImageData)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
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
