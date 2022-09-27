//
//  PreferenceData.swift
//  CNNPrivacy
//
//  Created by Massimiliano Petrucci on 8/24/18.
//

import Foundation

public struct PreferenceData: Codable {
    let Status: Int
    let Languages: [String]
    let Language: String
    let Purposes: [Purpose]
    let PreferenceCenterSettings: PreferenceCenterSettings
    let PreferenceCentreId: String
}
