//
//  MUPrivacyUtils.swift
//  MobileUserConsent
//
//  Created by Manoj K Malvi on 06/09/22.
//

import Foundation

@objc
class MUPrivacyUtils: NSObject {
        
    private static let comScoreForAllowDataSale = 1
    private static let comScoreForDoNotAllowDataSale = 0
    
    static let ccpaUnsupportedLocation = "1---"
    static let ccpaAllowDataSale = "1YNN"
    static let ccpaDoNotAllowDataSale = "1YYN"
    static let supportedLocations = ["US", "PR", "VI", "UM", ""]
    
    static func getDefaultUSPInfo() -> (usp: String, comScore: Int, uspBool: Bool, uspInt: Int) {
        return (usp: ccpaAllowDataSale, comScore: comScoreForAllowDataSale, uspBool: false, uspInt: 0)
    }
    
    static func getComScoreForUsp(usp: String) -> Int {
        switch usp {
        case ccpaAllowDataSale:
            return comScoreForAllowDataSale
        case ccpaDoNotAllowDataSale:
            return comScoreForDoNotAllowDataSale
        case ccpaUnsupportedLocation:
            return comScoreForAllowDataSale
        default:
            return comScoreForAllowDataSale
        }
    }
    
    static func isSupportedLocation(location: String) -> Bool {
        return supportedLocations.contains(location)
    }
}
