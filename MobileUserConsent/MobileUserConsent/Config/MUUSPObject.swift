//
//  MUUspObject.swift
//  MobileUserConsent
//
//  Created by Manoj K Malvi on 06/09/22.
//

import Foundation

@objc public class MUUSPObject: NSObject {
    
    @objc public let uspString: String
    @objc public let versionNumber: String
    @objc public let comscoreValue: Int

    @objc public init(uspString: String, versionNumber: String, comscoreValue: Int) {
        self.uspString = uspString
        self.versionNumber = versionNumber
        self.comscoreValue = comscoreValue
    }
    
    static func ==(lhs: MUUSPObject, rhs: MUUSPObject) -> Bool {
        return lhs.uspString == rhs.uspString && lhs.comscoreValue == rhs.comscoreValue
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let rhs = object as? MUUSPObject else {
            return false
        }
        
        return (uspString == rhs.uspString) && (comscoreValue == rhs.comscoreValue)
    }
}
