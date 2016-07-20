//
//  DataService.swift
//  QueueGda
//
//  Created by KonradRoj on 18.07.2016.
//  Copyright © 2016 BTSkyrise. All rights reserved.
//

import UIKit
import WatchConnectivity

protocol DataServiceDelegate {
    func didSelectItem(named name : String?, atZom : Int)
}

class DataService: NSObject, WCSessionDelegate {
    
    let parseService = ParseService()
    var session = WCSession.defaultSession()

    var delegate : DataServiceDelegate?
    
    func getDataForZom(zomNumber : Int, completion: (result: [Queue]) -> Void) {
        parseService.clearData()
        
        let url = "http://www.gdansk.pl/files/xml/qmatic-zom\(zomNumber).xml"
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!) { data, response, error in
            if error != nil || data == nil {
                print(error)
                return
            }
            
            let parser = NSXMLParser(data: data!)
            parser.delegate = self.parseService
            if parser.parse() {
                completion(result: self.queueObject(self.parseService.results))
            }
        }
        task.resume()
    }
    
    func queueObject(dictionary : [[String: String]]) -> [Queue] {
        var queueList = [Queue]()
        
        for item in dictionary {
            queueList.append(Queue.queueWithDictionaryObject(item))
        }
        
        return queueList
    }
    
    /**
     *  Watch Connectivity
     */
    
    func sendMessage(queueName : String?, zomIndex : Int) {
        var name = queueName
        if queueName == nil || queueName!.characters.count == 0 {
            name = "empty"
        }
        
        session.sendMessage([name! : zomIndex], replyHandler: { reply in }, errorHandler: { error in
            print(error)
        })
    }
    
    func session(session: WCSession, didReceiveFile file: WCSessionFile){
        print(#function)
        print(session)
    }
    
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        print(#function)
        print(session)
    }
    
    func sessionReachabilityDidChange(session: WCSession){
        print(#function)
        print(session)
        print("reachability changed:\(session.reachable)")
    }
    
    func sessionWatchStateDidChange(session: WCSession) {
        print(#function)
        print(session)
        print("reachable:\(session.reachable)")
    }
    
    internal func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        print(#function)
        if let data = message.first {
            self.delegate?.didSelectItem(named: data.0 == "empty" ? nil : data.0, atZom: data.1 as! Int)
            return
        }
        
        guard message["request"] as? String == "showAlert" else {return}
    }
    
    internal func activate() {
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
            print("watch activating WCSession")
        } else {
            print("watch does not support WCSession")
        }
        
        if !session.reachable {
            print("not reachable")
            return
        } else {
            print("watch is reachable")
        }
    }

}
