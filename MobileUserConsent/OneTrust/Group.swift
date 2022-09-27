//
//  Group.swift
//  CNNPrivacy
//
//  Created by alaa alshammari on 7/17/20.
//

import Foundation
@objc public class FirstPartyCookie: NSObject, Codable {
    @objc public var Name: String
    @objc public var SdkId: String
    @objc public var Description: String?
}

@objc public class Group: NSObject, Codable {
    public static func == (lhs: Group, rhs: Group) -> Bool {
        return (lhs.GroupId == rhs.GroupId)
    }
    
    @objc public var ShowInPopup: Bool
    @objc public var Order: String
    @objc public var OptanonGroupId: String
    @objc public var Parent: String
    @objc public var ShowSubgroup: Bool
    @objc public var ShowSubGroupDescription: Bool
    @objc public var ShowSubgroupToggle: Bool
    @objc public var GroupDescription: String
    @objc public var GroupDescriptionOTT: String
    @objc public var GroupName: String
    @objc public var IsIabPurpose: Bool
    @objc public var GeneralVendorsIds: [String]
    @objc public var FirstPartyCookies: [FirstPartyCookie]
    @objc public var Hosts: [String]
    @objc public var PurposeId: String
    @objc public var CustomGroupId: String
    @objc public var GroupId: String
    @objc public var Status: String
    @objc public var IsDntEnabled: Bool
    @objc public var DescriptionLegal: String
    @objc public var HasLegIntOptOut: Bool
    @objc public var HasConsentOptOut: Bool
    @objc public var IsGpcEnabled: Bool
    @objc public var type: String
    private var _transactionStatus:Int?
    @objc public var transactionStatus:GroupStatus {
        get { return GroupStatus(rawValue: _transactionStatus ?? 0) ?? .UNDEFINED}
        set { _transactionStatus = newValue.rawValue }
    }
}

@objc public enum GroupStatus: Int, CaseIterable {
    case ACTIVE = 1
    case WITHDRAWN = 0
    case EXPIRED = 2
    case ALWAYS_ACTIVE = -2
    case UNDEFINED = -1
}

/*
{"ShowInPopup":true,"Order":"26","OptanonGroupId":"ven","Parent":"SPD_BG","ShowSubgroup":true,"ShowSubGroupDescription":true,"ShowSubgroupToggle":false,"GroupDescription":"Share data with 3rd party vendor","GroupDescriptionOTT":"","GroupName":"Share data with 3rd party vendor","IsIabPurpose":false,"GeneralVendorsIds":[],"FirstPartyCookies":[{"Name":"DummySDKTester","SdkId":"b98c3b07-99ec-416f-ab35-3a59dae935e6","Description":null}],"Hosts":[],"PurposeId":"3EC2523A-10D1-487B-91D1-D7A445B9116B","CustomGroupId":"ven","GroupId":"0311aac9-98de-4040-af6a-d5baf083ba88","Status":"active","IsDntEnabled":false,"Type":"COOKIE","DescriptionLegal":"","HasLegIntOptOut":false,"HasConsentOptOut":true,"IsGpcEnabled":false}*/
