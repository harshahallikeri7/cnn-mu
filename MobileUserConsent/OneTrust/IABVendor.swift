//
//  IABVendor.swift
//  CNNPrivacy
//
//  Created by alaa alshammari on 10/27/20.
//  Copyright © 2020 CNN. All rights reserved.
//

import Foundation
public struct IABVendor: Codable {
    var purposes: [Int]? = nil
    var legIntPurposes: [Int]? = nil
    var flexiblePurposes: [Int]? = nil
    var specialPurposes: [Int]? =  nil
    var features: [Int]? =  nil
    var specialFeatures: [Int]? = nil
    var id: Int? = nil
    var name: String? = nil
    var policyUrl: String? = nil
    var iab2GVLVersion: Int? = nil
    var consent: Int? = nil
    var legIntStatus: Int? = nil
}
