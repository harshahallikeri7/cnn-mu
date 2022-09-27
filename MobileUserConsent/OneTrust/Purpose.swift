//
//  Purpose.swift
//  CNNPrivacy
//
//  Created by Massimiliano Petrucci on 8/23/18.
//  Copyright © 2018 CNN. All rights reserved.
//

import Foundation

public struct Purpose: Codable, Hashable {
    public static func == (lhs: Purpose, rhs: Purpose) -> Bool { return lhs.ID == rhs.ID }
    public var hashValue: Int { get { return ID.hashValue }}
    public func hash(into hasher: inout Hasher) { ID.hash(into: &hasher)}
    
    public var transactionStatus: String?// is missing in getDefaultPurposes calls
    public var externalReference: String?
    public var description: String?
    public var purposeType: PurposeTypes?
    public var languages: [PurposeLanguage]?
    public var topics: [PurposeTopic] = []
    public var status: String?
    public var label: String?
    public var ID: String?
    public var index: Int8?
    public var always_active: Bool = false
    public var hasConsentOptOut: Bool = false
    public var hasLegIntOptOut: Bool = false
    public var vendors: [String]? = []
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case transactionStatus = "TransactionStatus"
        case externalReference = "ExternalReference"
        case purposeType = "PurposeType"
        case description = "Description"
        case languages = "Languages"
        case status = "Status"
        case topics = "Topics"
        case label = "Label"
        case ID = "Id"
        case index = "Index"
        case always_active = "Always_active"
        case vendors = "Vendors"
        case hasConsentOptOut = "HasConsentOptOut"
        case hasLegIntOptOut = "HasLegIntOptOut"
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(transactionStatus, forKey: .transactionStatus)
        try container.encode(externalReference, forKey: .externalReference)
        try container.encode(purposeType?.name, forKey: .purposeType)
        try container.encode(description, forKey: .description)
        try container.encode(languages, forKey: .languages)
        try container.encode(topics, forKey: .topics)
        try container.encode(status, forKey: .status)
        try container.encode(label, forKey: .label)
        try container.encode(ID, forKey: .ID)
        try container.encode(index, forKey: .index)
        try container.encode(always_active, forKey: .always_active)
        try container.encode(vendors, forKey: .vendors)
        try container.encode(hasConsentOptOut, forKey: .hasConsentOptOut)
        try container.encode(hasLegIntOptOut, forKey: .hasLegIntOptOut)
    }
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        transactionStatus = try values.decode(String.self, forKey: .transactionStatus)
        description = try values.decode(String.self, forKey: .description)
        languages = try values.decode(Array.self, forKey: .languages)
        topics = try values.decode(Array.self, forKey: .topics)
        status = try values.decode(String.self, forKey: .status)
        label = try values.decode(String.self, forKey: .label)
        ID = try values.decode(String.self, forKey: .ID)
        index = try values.decode(Int8.self, forKey: .index)
        externalReference = "-1"
        always_active = self.status! == "always active" ? true : false
        purposeType = PurposeTypes(rawValue: self.typeToValue(strType: self.ID!))
        vendors = try values.decode(Array.self, forKey: .vendors)
        hasConsentOptOut = try values.decode(Bool.self, forKey: .hasConsentOptOut)
        hasLegIntOptOut = try values.decode(Bool.self, forKey: .hasLegIntOptOut)
    }
    
    func typeToValue(strType: String) -> String {
        switch strType {
        case "IABV2_1" :
            return "1"
        case "IABV2_10" :
            return "2"
        case "IABV2_2":
            return "3"
        case "IABV2_3":
            return "4"
        case "IABV2_4":
            return "5"
        case "IABV2_5":
            return "6"
        case "IABV2_6":
            return "7"
        case "IABV2_7":
            return "8"
        case "IABV2_8":
            return  "9"
        case "IABV2_9":
            return "10"
        case "IFEV2_1":
            return "11"
        case "IFEV2_2":
            return "12"
        case "IFEV2_3":
            return "13"
        case "ISFV2_1":
            return  "14"
        case "ISFV2_2":
            return "15"
        case "ISPV2_1":
            return "16"
        case "ISPV2_2":
            return "17"
        case "REQ":
            return "18"
        case "SPD_BG":
            return "19"
        default:
            return "-1"
        }
    }
}

public enum PurposeTypes: String, Codable {
    case IABV2_1 = "1"
    case IABV2_10 = "2"
    case IABV2_2 = "3"
    case IABV2_3 = "4"
    case IABV2_4 = "5"
    case IABV2_5 = "6"
    case IABV2_6 = "7"
    case IABV2_7 = "8"
    case IABV2_8 = "9"
    case IABV2_9 = "10"
    case IFEV2_1 = "11"
    case IFEV2_2 = "12"
    case IFEV2_3 = "13"
    case ISFV2_1 = "14"
    case ISFV2_2 = "15"
    case ISPV2_1 = "16"
    case ISPV2_2 = "17"
    case REQ = "18"
    case SPD_BG = "19"
    case undefined = "-1"
    
    public var name: String {
        get {
            switch self {
            case .IABV2_1:          return "IABV2_1"
            case .IABV2_2:          return "IABV2_2"
            case .IABV2_3:          return "IABV2_3"
            case .IABV2_4:          return "IABV2_4"
            case .IABV2_5:          return "IABV2_5"
            case .IABV2_6:          return "IABV2_6"
            case .IABV2_7:          return "IABV2_7"
            case .IABV2_8:          return "IABV2_8"
            case .IABV2_9:          return "IABV2_9"
            case .IABV2_10:         return "IABV2_10"
            case .IFEV2_1:          return "IFEV2_1"
            case .IFEV2_2:          return "IFEV2_2"
            case .IFEV2_3:          return "IFEV2_3"
            case .ISFV2_1:          return "ISFV2_1"
            case .ISFV2_2:          return "ISFV2_2"
            case .ISPV2_1:          return "ISPV2_1"
            case .ISPV2_2:          return "ISPV2_2"
            case .REQ:              return "REQ"
            case .SPD_BG:           return "SPD_BG"
            case .undefined:        return "UNDEFINED"
            }
        }
    }
}

public enum PurposeStatus: String {
    case active     = "ACTIVE"
    case withdrawn  = "WITHDRAWN"
    case expired    = "EXPIRED"
    case `default`  = "DEFAULT"
}
