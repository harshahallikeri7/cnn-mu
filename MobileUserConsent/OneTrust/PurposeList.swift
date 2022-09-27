//
//  PurposeList.swift
//  CNNPrivacy
//
//  Created by Massimiliano Petrucci on 10/2/18.
//

import Foundation

public struct PurposeList: Codable {
    public var purposes: [Purpose]
    
    public init(p: [Purpose]) {
        self.purposes = p
    }

    enum CodingKeys: String, CodingKey
    {
        case purposes = "Purposes"
    }
}
