//
//  PurposeTopic.swift
//  CNNPrivacy
//
//  Created by Mark Storey on 8/9/19.
//

import Foundation
// MARK: - PurposeTopic
public struct PurposeTopic: Codable {
    public let id, name: String
    let languages: [Language]
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case languages = "Languages"
    }
}

// MARK: - Language
struct Language: Codable {
    let name, language: String
    let languageDefault: Bool
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case language = "Language"
        case languageDefault = "Default"
    }
}
