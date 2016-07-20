//
//  QueueTableViewRow.swift
//  QueueGda
//
//  Created by KonradRoj on 18.07.2016.
//  Copyright © 2016 BTSkyrise. All rights reserved.
//

import WatchKit

class QueueTableViewRow: NSObject {

    @IBOutlet var typeLabel: WKInterfaceLabel!
    @IBOutlet var currentNumberTitleLabel: WKInterfaceLabel!
    @IBOutlet var numberLabel: WKInterfaceLabel!
    @IBOutlet var queueCountLabel: WKInterfaceLabel!
    @IBOutlet var postsCount: WKInterfaceLabel!
    @IBOutlet var averageTimeLabel: WKInterfaceLabel!
    
    func makeSelected(isSelected : Bool) {
        if !isSelected {
            typeLabel.setTextColor(UIColor.whiteColor())
            currentNumberTitleLabel.setTextColor(UIColor.whiteColor())
            numberLabel.setTextColor(UIColor.whiteColor())
            queueCountLabel.setTextColor(UIColor.whiteColor())
            postsCount.setTextColor(UIColor.whiteColor())
            averageTimeLabel.setTextColor(UIColor.whiteColor())
        } else {
            typeLabel.setTextColor(UIColor.blackColor())
            currentNumberTitleLabel.setTextColor(UIColor.blackColor())
            numberLabel.setTextColor(UIColor.blackColor())
            queueCountLabel.setTextColor(UIColor.blackColor())
            postsCount.setTextColor(UIColor.blackColor())
            averageTimeLabel.setTextColor(UIColor.blackColor())
        }
    }
    
}
