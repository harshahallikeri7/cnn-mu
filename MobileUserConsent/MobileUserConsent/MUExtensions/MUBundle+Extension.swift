//
//  MUBundle+Extension.swift
//  MobileUserConsent
//
//  Created by Manoj K Malvi on 07/09/22.
//

import Foundation



extension Bundle {
    
    static var MainBundle: Bundle {
        return Bundle.main
    }
    
    static var BundleIdentifier: String? {
        return MainBundle.bundleIdentifier
    }
    
    static var BundleInfoDictionary: [String: Any]? {
        return MainBundle.infoDictionary
    }
    
    static var VersionNumber: String? {
        return BundleInfoDictionary?.valueForString(key: "CFBundleShortVersionString")
    }
    
    static var BuildNumber: String? {
        return BundleInfoDictionary?.valueForString(key: "CFBundleVersion")
    }
    
    static var ApplicationName: String? {
        return BundleInfoDictionary?.valueForString(key: "CFBundleDisplayName")
    }
}
