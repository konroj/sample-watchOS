//
//  ViewController.swift
//  QueueGda
//
//  Created by KonradRoj on 18.07.2016.
//  Copyright © 2016 BTSkyrise. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate, DataServiceDelegate {

    @IBOutlet weak var zomTitleLabel: UILabel!
    @IBOutlet weak var zomAddressLabel: UILabel!
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let dataService = DataService()
    
    var queueList = [Queue]()
    var selectedName : String?
    var queueRefreshTimer : NSTimer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataService.delegate = self
        dataService.activate()
        
        tableView.backgroundColor = UIColor.clearColor()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 126
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 8, 0)
        
        tabBar.selectedItem = tabBar.items?.first
        getTableData(true)
        
        queueRefreshTimer = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: #selector(ViewController.getTableData(_:)), userInfo: nil, repeats: true)
    }

    /**
     *  TableView
     */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return queueList.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("QueueTableViewCell", forIndexPath: indexPath) as! QueueTableViewCell
        
        let queue = queueList[indexPath.section]
        
        let queueName = queue.groupName.characters.count > 0 ? queue.groupName : queue.groupLetter
        cell.typeLabel.text = NSLocalizedString(queueName, comment: "")
        
        if queueName == selectedName {
            cell.makeSelected(true)
        } else {
            cell.makeSelected(false)
        }
        
        cell.currentNumberTitleLabel.text = NSLocalizedString("Current number", comment: "")
        cell.numberLabel.text = queue.groupLetter + queue.actualNumber
        
        let attrs = [NSFontAttributeName : UIFont.boldSystemFontOfSize(12)]
        
        let queueTitleAttrString = NSMutableAttributedString(string: NSLocalizedString("People in line: ", comment: ""))
        let postTitleAttrString = NSMutableAttributedString(string: NSLocalizedString("Number of posts: ", comment: ""))
        let timeTitleAttrString = NSMutableAttributedString(string: NSLocalizedString("Avg. service time: ", comment: ""))
        
        let queueCountAttrString = NSAttributedString(string: "\(queue.queueLength)", attributes:attrs)
        let postCountAttrString = NSAttributedString(string: "\(queue.postsCount)", attributes:attrs)
        let avgTimeAttrString = NSAttributedString(string: "\(queue.averageTimeInMinutes) min", attributes:attrs)
        
        queueTitleAttrString.appendAttributedString(queueCountAttrString)
        postTitleAttrString.appendAttributedString(postCountAttrString)
        timeTitleAttrString.appendAttributedString(avgTimeAttrString)
        
        cell.queueCountLabel.attributedText = queueTitleAttrString
        cell.postsCount.attributedText = postTitleAttrString
        cell.averageTimeLabel.attributedText = timeTitleAttrString
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let queue = queueList[indexPath.section]
        let queueName = queue.groupName.characters.count > 0 ? queue.groupName : queue.groupLetter
        
        if queueName == selectedName {
            selectedName = nil
        } else {
            selectedName = queueName
        }
        
        self.dataService.sendMessage(selectedName, zomIndex: tabBar.items!.indexOf(tabBar.selectedItem!)!)
        
        UIView.transitionWithView(self.tableView, duration: 0.4, options: .TransitionCrossDissolve, animations: {self.tableView.reloadData()}, completion: nil)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 3.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    /**
     *  TabBar
     */

    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        getTableData(true)
    }
    
    /**
     *  Data
     */
    
    func getTableData(withAnimation : Bool) {
        if withAnimation {
            queueList.removeAll()
            tableView.reloadData()
        }
        
        zomTitleLabel.text = kZomName + "\(tabBar.items!.indexOf(tabBar.selectedItem!)! + 1)"
        zomAddressLabel.text = Zom.allValues[tabBar.items!.indexOf(tabBar.selectedItem!)!].addressString()
        
        dataService.getDataForZom(tabBar.items!.indexOf(tabBar.selectedItem!)!) { (result) in
            dispatch_async(dispatch_get_main_queue(),{
                self.queueList = result
                
                if withAnimation {
                    UIView.transitionWithView(self.tableView, duration: 0.4, options: .TransitionCrossDissolve, animations: {self.tableView.reloadData()}, completion: nil)
                } else {
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    /**
     *  DataServiceDelegate
     */
    
    func didSelectItem(named name: String?, atZom: Int) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tabBar.selectedItem = self.tabBar.items![atZom]
            self.selectedName = name
            
            self.getTableData(true)
        })
    }
    
    /**
     *  View
     */
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}

