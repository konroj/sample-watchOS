//
//  InterfaceController.swift
//  QueueGda WatchKit Extension
//
//  Created by KonradRoj on 18.07.2016.
//  Copyright © 2016 BTSkyrise. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet var tableView: WKInterfaceTable!
    
    let dataService = DataService()
    let watchService = WatchInternalService.shared.instance
    var queueList = [Queue]()
    var queueRefreshTimer : NSTimer?
    
    var selectedName : String?
    var currentPageNumber = 0
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if context != nil {
            self.currentPageNumber = context as! Int
            
            let text = "RST" + " " + "\(self.currentPageNumber + 1)"
            self.setTitle(text)
        }
        
        watchService.connectedControllers.append(self)
        dataService.delegate = watchService
        dataService.activate()
    }

    override func willActivate() {
        super.willActivate()
        
        setupTable(selectedName)
        getTableData()
        queueRefreshTimer = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: #selector(InterfaceController.getTableData), userInfo: nil, repeats: true)
    }

    override func didDeactivate() {
        super.didDeactivate()
        
        queueRefreshTimer?.invalidate()
    }
    
    /**
     *  TableView
     */
    
    func setupTable(withName : String?) {
        var rows = [String]()
        for _ in queueList {
            rows.append("QueueTableViewRow")
        }
        
        tableView.setRowTypes(rows)
        
        for i in 0 ..< queueList.count {
            if let cell = tableView.rowControllerAtIndex(i) as? QueueTableViewRow {
                let queue = queueList[i]
                
                let queueName = queue.groupName.characters.count > 0 ? queue.groupName : queue.groupLetter
                cell.typeLabel.setText(NSLocalizedString(queueName, comment: ""))

                if queueName == withName {
                    cell.makeSelected(true)
                } else {
                    cell.makeSelected(false)
                }
                
                cell.currentNumberTitleLabel.setText(NSLocalizedString("Current number", comment: ""))
                cell.numberLabel.setText(queue.groupLetter + queue.actualNumber)
                
                let attrs = [NSFontAttributeName : UIFont.boldSystemFontOfSize(10)]
                
                let queueTitleAttrString = NSMutableAttributedString(string: NSLocalizedString("People in line: ", comment: ""))
                let postTitleAttrString = NSMutableAttributedString(string: NSLocalizedString("Number of posts: ", comment: ""))
                let timeTitleAttrString = NSMutableAttributedString(string: NSLocalizedString("Avg. service time: ", comment: ""))
                
                let queueCountAttrString = NSAttributedString(string: "\(queue.queueLength)", attributes:attrs)
                let postCountAttrString = NSAttributedString(string: "\(queue.postsCount)", attributes:attrs)
                let avgTimeAttrString = NSAttributedString(string: "\(queue.averageTimeInMinutes) min", attributes:attrs)
                
                queueTitleAttrString.appendAttributedString(queueCountAttrString)
                postTitleAttrString.appendAttributedString(postCountAttrString)
                timeTitleAttrString.appendAttributedString(avgTimeAttrString)
                
                cell.queueCountLabel.setAttributedText(queueTitleAttrString)
                cell.postsCount.setAttributedText(postTitleAttrString)
                cell.averageTimeLabel.setAttributedText(timeTitleAttrString)
            }
        }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        let queue = queueList[rowIndex]
        let queueName = queue.groupName.characters.count > 0 ? queue.groupName : queue.groupLetter
        
        if queueName == selectedName {
            selectedName = nil
        } else {
            selectedName = queueName
        }
        
        self.dataService.sendMessage(selectedName, zomIndex: currentPageNumber)
        
        setupTable(selectedName)

    }
    
    /**
     *  Data
     */

    func getTableData() {
        dataService.getDataForZom(self.currentPageNumber) { (result) in
            self.queueList = result
            self.setupTable(self.selectedName)
        }
    }

}
