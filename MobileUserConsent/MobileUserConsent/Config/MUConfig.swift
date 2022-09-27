//
//  muConfig.swift
//  MobileUserConsent
//
//  Created by hhallikeri on 7/6/22.
//

import Foundation

@objc public class MUConfig: NSObject {
    
    @objc public let environment: MUEnvironment
    @objc public let platform: MUPlatform
    @objc public let brand: MUBrand
    @objc public let oneTrustUrl: String
    @objc public let oneTrustId: String
    @objc public let location: String
    @objc public let region: String
    @objc public let country: String
    @objc public let language: String
    
    @objc public init(environment: MUEnvironment,
                      platform: MUPlatform,
                      brand: MUBrand,
                      oneTrustUrl: String,
                      oneTrustId: String,
                      location: String,
                      region: String,
                      country: String,
                      language: String
    ) {
        self.environment = environment
        self.platform = platform
        self.brand = brand
        self.oneTrustUrl = oneTrustUrl
        self.oneTrustId = oneTrustId
        self.location = location
        self.region = region
        self.country = country
        self.language = language
    }
}
