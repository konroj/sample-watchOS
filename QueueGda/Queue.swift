//
//  Queue.swift
//  QueueGda
//
//  Created by KonradRoj on 18.07.2016.
//  Copyright © 2016 BTSkyrise. All rights reserved.
//

import UIKit

class Queue: NSObject {
    
    var lp : String = ""
    var groupId : String = ""
    var groupLetter : String = ""
    var groupName : String = ""
    var actualNumber : String = ""
    var queueLength : Int = 0
    var postsCount : Int = 0
    var averageTimeInMinutes : Int = 0
    
    class func queueWithDictionaryObject(object : [String: String]) -> Queue {
        let queue = Queue()
        
        queue.lp = object["LP"] == nil ? "" : object["LP"]!
        queue.groupId = object["IDGRUPY"] == nil ? "" : object["IDGRUPY"]!
        queue.groupLetter = object["LITERAGRUPY"] == nil ? "" : object["LITERAGRUPY"]!
        queue.groupName = object["NAZWAGRUPY"] == nil ? "" : object["NAZWAGRUPY"]!
        queue.actualNumber = object["AKTUALNYNUMER"] == nil ? "" : object["AKTUALNYNUMER"]!
        queue.queueLength = object["LICZBAKLWKOLEJCE"] == nil ? 0 : Int(object["LICZBAKLWKOLEJCE"]!)!
        queue.postsCount = object["LICZBACZYNNYCHSTAN"] == nil ? 0 : Int(object["LICZBACZYNNYCHSTAN"]!)!
        queue.averageTimeInMinutes = object["CZASOBSLUGI"] == nil ? 0 : Int(object["CZASOBSLUGI"]!)!
        
        return queue
    }

}
