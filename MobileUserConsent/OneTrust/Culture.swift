//
//  Culture.swift
//  CNNPrivacy
//
//  Created by alaa alshammari on 7/17/20.
//

import Foundation
public struct Culture: Codable {
   public var domainData: DomainData

    enum CodingKeys: String, CodingKey {
        case domainData = "DomainData"
    }
}
