//
//  HomeTableViewCell.swift
//  FoursquareDemo
//
//  Created by Mauricio Vasquez on 1/26/16.
//  Copyright © 2016 TestIO. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var venueName: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
