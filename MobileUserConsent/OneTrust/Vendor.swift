//
//  Vendor.swift
//  CNNPrivacy
//
//  Created by Massimiliano Petrucci on 8/23/18.
//  Copyright © 2018 CNN. All rights reserved.
//

import Foundation


@objc public class Vendor: NSObject, Codable {
    @objc var name: String
    @objc var policyUrl: String
    @objc var purposes: [String]
    @objc var legPurposes: [String]
    @objc var specialPurposes: [String]
    @objc var features: [String]
    @objc var specialFeatures: [String]
    @objc var isIab: Bool = false
    @objc var consentStatus: Bool = false
    @objc var objectToLeg: Bool = false
    @objc var index: Int8 = 10
    
    public init(name: String, policyUrl: String, purposes: [String], legPurposes: [String], specialPurposes: [String], features: [String], specialFeatures: [String], isIab: Bool, consentStatus: Bool, objectToLeg: Bool, index: Int8) {
    self.name = name
    self.policyUrl = policyUrl
    self.purposes = purposes
    self.legPurposes = legPurposes
    self.specialPurposes = specialPurposes
    self.features = features
    self.specialFeatures = specialFeatures
    self.isIab = isIab
    self.consentStatus = consentStatus
    self.objectToLeg = objectToLeg
    self.index = index
    }
    
    enum CodingKeys: String, CodingKey {
    case name = "Name"
    case policyUrl = "PolicyUrl"
    case purposes = "Purposes"
    case legPurposes = "LegPurposes"
    case specialPurposes = "SpecialPurposes"
    case features = "Features"
    case specialFeatures = "SpecialFeatures"
    case isIab = "IsIab"
    case consentStatus = "ConsentStatus"
    case objectToLeg = "ObjectToLeg"
    case index = "Index"
    }
    
    public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
    try container.encode(policyUrl, forKey: .policyUrl)
    try container.encode(purposes, forKey: .purposes)
    try container.encode(legPurposes, forKey: .legPurposes)
    try container.encode(specialPurposes, forKey: .specialPurposes)
    try container.encode(features, forKey: .features)
    try container.encode(specialFeatures, forKey: .specialFeatures)
    try container.encode(isIab, forKey: .isIab)
    try container.encode(consentStatus, forKey: .consentStatus)
    try container.encode(objectToLeg, forKey: .objectToLeg)
    try container.encode(index, forKey: .index)
    }
    
    required public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    name = try values.decode(String.self, forKey: .name)
    policyUrl = try values.decode(String.self, forKey: .policyUrl)
    purposes = try values.decode(Array.self, forKey: .purposes)
    legPurposes = try values.decode(Array.self, forKey: .legPurposes)
    specialPurposes = try values.decode(Array.self, forKey: .specialPurposes)
    features = try values.decode(Array.self, forKey: .features)
    specialFeatures = try values.decode(Array.self, forKey: .specialFeatures)
    consentStatus = try values.decode(Bool.self, forKey: .consentStatus)
    objectToLeg = try values.decode(Bool.self, forKey: .objectToLeg)
    index = try values.decode(Int8.self, forKey: .index)
    }
}
