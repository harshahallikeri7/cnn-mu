//
//  OTData.swift
//  CNNPrivacy
//
//  Created by alaa alshammari on 7/17/20.
//

import Foundation
public struct OTData: Codable {
   public var culture: Culture

    enum CodingKeys: String, CodingKey {
        case culture = "culture"
    }
}
