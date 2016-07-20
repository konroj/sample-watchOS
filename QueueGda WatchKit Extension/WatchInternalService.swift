//
//  WatchInternalService.swift
//  Queue Gdansk
//
//  Created by KonradRoj on 19.07.2016.
//  Copyright © 2016 BTSkyrise. All rights reserved.
//

import WatchKit

class WatchInternalService: NSObject, DataServiceDelegate {

    var connectedControllers = [InterfaceController]()
    
    struct shared {
        static let instance = WatchInternalService()
    }
    
    /**
     *  DataServiceDelegate
     */
    
    func didSelectItem(named name: String?, atZom: Int) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            for controller in self.connectedControllers {
                controller.selectedName = name
                controller.getTableData()
            }
        })
    }
    
}
