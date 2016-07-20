//
//  ParseService.swift
//  Queue Gdansk
//
//  Created by KonradRoj on 19.07.2016.
//  Copyright © 2016 BTSkyrise. All rights reserved.
//

import UIKit

class ParseService: NSObject, NSXMLParserDelegate {

    /**
     *  Parser
     */
    
    let recordKey = "GRUPY"
    let dictionaryKeys = ["LP", "IDGRUPY", "LITERAGRUPY", "NAZWAGRUPY", "AKTUALNYNUMER", "LICZBAKLWKOLEJCE", "LICZBACZYNNYCHSTAN" , "CZASOBSLUGI"]
    
    var results = [[String: String]]()
    var currentDictionary = [String: String]()
    var currentValue: String?
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if elementName == recordKey {
            currentDictionary = [String : String]()
        } else if dictionaryKeys.contains(elementName) {
            currentValue = String()
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        currentValue? += string
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == recordKey {
            results.append(currentDictionary)
            currentDictionary = [String: String]()
        } else if dictionaryKeys.contains(elementName) {
            currentDictionary[elementName] = currentValue
            currentValue = nil
        }
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print(parseError)
        clearData()
    }
    
    func clearData() {
        currentValue = nil
        currentDictionary = [String: String]()
        results = [[String: String]]()
    }
    
}
