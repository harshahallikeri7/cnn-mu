//
//  OneTrustData.swift
//  cnngoPrivacyDemo
//
//  Created by Munger, Cody on 9/3/21.
//

import Foundation

class OneTrustCodingKey : CodingKey {
    var stringValue: String = ""
    
    required init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    var intValue: Int?
    
    required init?(intValue: Int) {
        self.intValue = intValue
    }
}

class OneTrustDecoder:JSONDecoder {
    override init() {
        super.init()
        
        dateDecodingStrategy = .iso8601
        
        keyDecodingStrategy = KeyDecodingStrategy.custom { keys in
            for key in keys {
                print(key)
                if (key.stringValue == "Type") {
                    return OneTrustCodingKey(stringValue: "type")!
                }
            }
            
            return keys[keys.count - 1]
        }
    }
}

class OneTrustData : Codable {
    public class Status: Codable {
        public class StatusStr:Codable {
            public var code:Int
            public var msg:String
        }
        
        public var application:StatusStr
        public var profile:StatusStr
    }

    public class Culture: Codable {
        public class DomainData:Codable {
            public class publisherStr:Codable {
                public var restrictions:[String:[String:Int]]
            }
            
            public class OverridenVendor:Codable {
                public var active:Bool
                public var legInt:Bool
                public var consent:Bool
                public var disabledCP:[Int]?
                public var disabledSF:[Int]?
                
                init(decoder:Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    active = try container.decode(Bool.self, forKey: .active)
                    legInt = try container.decode(Bool.self, forKey: .legInt)
                    consent = try container.decode(Bool.self, forKey: .consent)
                    disabledCP = try container.decodeIfPresent([Int].self, forKey: .disabledCP)
                    disabledSF = try container.decodeIfPresent([Int].self, forKey: .disabledSF)
                }
            }
            
            public var publisher:publisherStr?
            public var Groups:[Group]
            public var Vendors:[Int]
            public var OverriddenVendors:[String:OverridenVendor]?
            //OverriddenGoogleVendors
            public var UseGoogleVendors:Bool
            public var LastReconsentDate:Int64
            public var ShowAlertNotice:Bool
            public var IsConsentLoggingEnabled:Bool
            public var IsIabEnabled:Bool
            public var IabType:String
            
            public var ConsentModel:String
            public var VendorConsentModel:String
            public var AdvancedAnalyticsCategory:String
            public var PCGrpDescLinkPosition:String?
            public var PublisherCC:String
        }
        
        public var DomainData:DomainData
        public var CommonData:CommonData
        public var NtfyConfig:NtfyConfig
        public class NtfyConfig:Codable {}
        
        public class CommonData:Codable {
            public class ConsentIntegration:Codable {
                public var ConsentApi:String
                public var RequestInformation:String
            }
            
            public var ConsentIntegration:ConsentIntegration
        }
        
    }
    
    class Domain: Codable {
        public class TennantFeaturesStr: Codable {
            public var CookieV2BannerFocus:Bool
            public var CookieV2GPC:Bool
            public var CookieV2AssignTemplateRule:Bool
            public var CookieV2TCF21:Bool
            public var CookieV2GeneralVendors:Bool
            public var CookieV2CookieTranslations:Bool
            public var CookiesSameSiteNone:Bool
        }
        
        public class IABDataStr: Codable {
            public var cookieVersion:String
            public var createdTime:String
            public var updatedTime:String
            public var cmpId:String
            public var cmpVersion:String
            public var consentScreen:String
            public var consentLanguage:String?
            public var vendorListVersion:Int
            public var maxVendorId:Int
            public var encodingType:String
            public var globalVendorListUrl:String
        }
        
        public class RuleSet: Codable {
            public var Id:String
            public var Name:String
            public var Countries:[String]
            public var States: [String:[String]]
            public var LanguageSwitcherPlaceholder: [String:String]
            public var BannerPushesDown:Bool
            public var Default:Bool
            public var Global:Bool
            public var type:String
        }
        
        public class GoogleData: Codable {
            public var vendorListVersion:Int
            public var googleVendorListUrl:String
        }
        
        public class RuleDetails: Codable {
            public var name:String
            public var type:String
        }
        
        public var CookieSPAEnabled:Bool
        public var UseV2:Bool
        public var MobileSDK:Bool
        public var SkipGeolocation:Bool
        public var ScriptType:String
        public var ScriptVersion:String
        public var PublishVersion:String
        public var OptanonDataJSON:String
        public var GeolocationUrl:String
        public var RuleSet:[RuleSet]
        public var IabData:IABDataStr
        public var IabV2Data:IABDataStr
        public var ScriptDynamicLoadEnabled:Bool
        public var TenantFeatures:TennantFeaturesStr
        public var IsSuppressBanner:Bool
        public var IsSuppressPC:Bool
        public var PublisherCC:String
        public var SyncGroupId:String?
        public var TenantId:String
        public var ConsentWorkerServiceUrl:String
        public var GoogleData:GoogleData
        public var ruleDetails:RuleDetails
        public var countryCode:String
        public var regionCode:String
    }
    
    public var status:Status
    public var domain:Domain
    public var culture:Culture
}

