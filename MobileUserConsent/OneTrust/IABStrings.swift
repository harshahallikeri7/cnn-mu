//
//  IABStrings.swift
//  CNNPrivacy
//
//  Created by Massimiliano Petrucci on 8/30/18.
//

import Foundation

public struct IABStrings: Codable {
    public let cmpPresent: Bool
    public let subjectToGDPR: String
    public let consentString: String
    public let parsedVendorConsent: String
    public let parsedPurposeConsent: String
    
    enum CodingKeys: String, CodingKey
    {
        case cmpPresent = "IABConsent_CMPPresent"
        case subjectToGDPR = "IABConsent_SubjectToGDPR"
        case consentString = "IABConsent_ConsentString"
        case parsedVendorConsent = "IABConsent_ParsedVendorConsents"
        case parsedPurposeConsent = "IABConsent_ParsedPurposeConsents"
    }
}
