//
//  PurposeLanguage.swift
//  CNNPrivacy
//
//  Created by Massimiliano Petrucci on 9/10/18.
//

import Foundation

public struct PurposeLanguage: Codable {
    
    let name: String
    let description: String
    let language: String
    let `default`: Bool

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case `default` = "Default"
        case language = "Language"
        case description = "Description"
    }
}
