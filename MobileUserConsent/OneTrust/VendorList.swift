//
//  VendorList.swift
//  CNNPrivacy
//
//  Created by Massimiliano Petrucci on 10/2/18.
//

import Foundation

public struct VendorList: Codable {
    // optionals are needed for SaveVendors
    public let lastUpdated: String?
    public let vendorListVersion: Int?
    public let features: [FeaturePurpose]?
    public let purposes: [FeaturePurpose]?
    // Made optional because OTSDK will not send vendor list in GDPR 2.0
    public let vendors: [Vendor]?
}
