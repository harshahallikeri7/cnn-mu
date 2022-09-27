//
//  PurposeReceipt.swift
//  CNNPrivacy
//
//  Created by Massimiliano Petrucci on 8/31/18.
//

import Foundation

public struct PurposeReceipt: Codable {
    // this object is not documented so for safety reasons,
    // the values are considered optional to be defensive against backend changes
    public let receiptGuid: String?
    public let status: Bool?
    public let messages: [String]?
    public let ID: String?
    
    enum CodingKeys: String, CodingKey {
        case receiptGuid = "ReceiptGuid"
        case status = "Status"
        case messages = "Messages"
        case ID = "Id"
    }
}

struct PurposeReceiptList: Codable {
    let purposes: [PurposeReceipt]
    
    enum CodingKeys: String, CodingKey {
        case purposes = "Purposes"
    }
}
