//
//  MainInterfaceController.swift
//  QueueGda
//
//  Created by KonradRoj on 18.07.2016.
//  Copyright © 2016 BTSkyrise. All rights reserved.
//

import WatchKit
import Foundation


class MainInterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    override func willActivate() {
        super.willActivate()
        
        self.presentControllerWithNames(["InterfaceController", "InterfaceController", "InterfaceController", "InterfaceController"], contexts: [0, 1, 2, 3])
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

}
