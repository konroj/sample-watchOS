//
//  Consts.swift
//  Queue Gdansk
//
//  Created by KonradRoj on 19.07.2016.
//  Copyright © 2016 BTSkyrise. All rights reserved.
//

import UIKit

let kZomName = NSLocalizedString("Residents Services Team No.", comment: "")
let kZom0Address = "ul. Partyzantów 74"
let kZom1Address = "ul. Milskiego 1"
let kZom2Address = "ul. Nowe Ogrody 8/12"
let kZom3Address = "ul. Wilanowska 2"

enum Zom {
    case Zero, First, Second, Third
    
    func addressString() -> String {
        switch self {
        case .Zero:
            return kZom0Address
        case .First:
            return kZom1Address
        case .Second:
            return kZom2Address
        case .Third:
            return kZom3Address
        }
    }
    
    static let allValues = [Zero, First, Second, Third]
}

