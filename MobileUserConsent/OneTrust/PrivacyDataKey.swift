//
//  PrivacyDataKey.swift
//  CNNPrivacy
//
//  Created by Mark Storey on 10/11/18.
//  Copyright © 2018 CNN. All rights reserved.
//

import Foundation

// wrapper to allow us to substitute our mapped string keys.
public struct PrivacyDataKey : CodingKey {
    
    public var stringValue: String
    public var intValue: Int?
    
    init(_ base: CodingKey) {
        self.init(stringValue: base.stringValue, intValue: base.intValue)
    }
    
    public init(stringValue: String) {
        self.stringValue = stringValue
    }
    
    public init(intValue: Int) {
        self.stringValue = "\(intValue)"
        self.intValue = intValue
    }
    
    init(stringValue: String, intValue: Int?) {
        self.stringValue = stringValue
        self.intValue = intValue
    }
}
extension JSONEncoder.KeyEncodingStrategy {
    
    public static var convertToLowerCamelCase: JSONEncoder.KeyEncodingStrategy {
        return .custom { codingKeys in
            var key = PrivacyDataKey(codingKeys.last!)
            // lowercase first letter
            if let firstChar = key.stringValue.first {
                let i = key.stringValue.startIndex
                key.stringValue.replaceSubrange(
                    i ... i, with: String(firstChar).lowercased()
                )
            }
            return key
        }
    }
}

extension JSONDecoder.KeyDecodingStrategy {
    
    public static var convertToUpperCamelCase: JSONDecoder.KeyDecodingStrategy {
        return .custom { codingKeys in
            var key = PrivacyDataKey(codingKeys.last!)
            // uppercase first letter
            if let firstChar = key.stringValue.first {
                let i = key.stringValue.startIndex
                key.stringValue.replaceSubrange(
                    i ... i, with: String(firstChar).uppercased()
                )
            }
            return key
        }
    }
}
