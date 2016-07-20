//
//  QueueTableViewCell.swift
//  QueueGda
//
//  Created by KonradRoj on 18.07.2016.
//  Copyright © 2016 BTSkyrise. All rights reserved.
//

import UIKit

class QueueTableViewCell: UITableViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var currentNumberTitleLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var queueCountLabel: UILabel!
    @IBOutlet weak var postsCount: UILabel!
    @IBOutlet weak var averageTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 2.0
    }
    
    func makeSelected(isSelected : Bool) {
        if isSelected {
            backgroundColor = UIColor.blackColor()
            typeLabel.textColor = UIColor.whiteColor()
            currentNumberTitleLabel.textColor = UIColor.whiteColor()
            numberLabel.textColor = UIColor.whiteColor()
            queueCountLabel.textColor = UIColor.whiteColor()
            postsCount.textColor = UIColor.whiteColor()
            averageTimeLabel.textColor = UIColor.whiteColor()
        } else {
            backgroundColor = UIColor.whiteColor()
            typeLabel.textColor = UIColor.blackColor()
            currentNumberTitleLabel.textColor = UIColor.blackColor()
            numberLabel.textColor = UIColor.blackColor()
            queueCountLabel.textColor = UIColor.blackColor()
            postsCount.textColor = UIColor.blackColor()
            averageTimeLabel.textColor = UIColor.blackColor()
        }
    }

}
