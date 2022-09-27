//
//  DomainData.swift
//  CNNPrivacy
//
//  Created by alaa alshammari on 7/17/20.
//

import Foundation
public struct DomainData: Codable {

    public var groups: [Group]

    enum CodingKeys: String, CodingKey {
        case groups = "Groups"
    }
}
