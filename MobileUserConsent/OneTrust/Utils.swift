//
//  Utils.swift
//  CNNPrivacy
//
//  Created by alaa alshammari on 7/17/20.
//
import Foundation

#if os(tvOS)
import OTPublishersHeadlessSDKtvOS
#else
import OTPublishersHeadlessSDK
#endif

class Utils: NSObject {
    public let domainURL: String = "cdn.cookielaw.org"
    public let PROD_DOMAIN_ID = "c2517518-a49e-4c41-9fbe-aedac052bd2e"
    public let TEST_DOMAIN_ID = "c2517518-a49e-4c41-9fbe-aedac052bd2e-test"
    public let OTT_DATA_FETCH_RESULT = "OTT Data fetch result: "
    public let WITH_DATA = "with Data"
    public let AND_ERROR = "and error"
    public let ISFV2_1 = "ISFV2_1" // Utilized as ignored PurposeID
    public let ISFV2_2 = "ISFV2_2" // Ignored PurposeID for display
    
    public let IABV2_1 = "IABV2_1"
    public let IABV2_2 = "IABV2_2"
    public let IABV2_3 = "IABV2_3"
    public let IABV2_4 = "IABV2_4"
    public let IABV2_5 = "IABV2_5"
    public let IABV2_6 = "IABV2_6"
    public let IABV2_7 = "IABV2_7"
    public let IABV2_8 = "IABV2_8"
    public let IABV2_9 = "IABV2_9"
    public let IABV2_10 = "IABV2_10"
    public let IFEV2_1 = "IFEV2_1"
    public let IFEV2_2 = "IFEV2_2"
    public let IFEV2_3 = "IFEV2_3"
    public let ISPV2_1 = "ISPV2_1"
    public let ISPV2_2 = "ISPV2_2"
    public let SPD_BG = "SPD_BG"
    public let GDPRPURPOSES = ["IABV2_1", "IABV2_2","IABV2_3","IABV2_4" ,"IABV2_5", "IABV2_6","IABV2_7", "IABV2_8", "IABV2_9", "IABV2_10"]
    public let CCPAPURPOSES = ["SPD_BG"]
    
    public func convertPurposesFromIntsToStrings(intPurposes: [Int]?, targetDic: [Int: String]) -> [String] {
        var generalPurposesHolder: [String] = []
        intPurposes?.forEach({ ven in
            let purpose: String? = targetDic[ven]
            if purpose?.isEmpty == false {
                generalPurposesHolder.append(purpose ?? "")
            }
        })
        return generalPurposesHolder
    }
    
    enum PrivacyFeature: String {
        case moat
        case amazon
        case kochava
        case comscore
        case outbrain = "outbrain_iab"
        case chartbeat
        case appdynamics = "app_dynamics"
        case apptentive
        case conviva
        case omniture
        case zion
        case vizbee
        case oneSignal = "one_signal"
        case dfp
        case freewheel = "freewheel_iab"
        case auditude = "auditude_lspa"
        case krux
        case optimizely
        case segment
        case prism
        case airship
    }
    public let iabVendors = ["kochava","comscore","dfp","freewheel_iab","outbrain_iab","amazon"]
    public let iabVendorsIdMap: [String: String] = [
        PrivacyFeature.amazon.rawValue: "793",
        PrivacyFeature.outbrain.rawValue: "164",
        PrivacyFeature.freewheel.rawValue: "285",
        PrivacyFeature.dfp.rawValue: "755",
        PrivacyFeature.comscore.rawValue: "77",
        PrivacyFeature.kochava.rawValue: "544"
    ]
    public let privacyLinks: [String: String] = [
        PrivacyFeature.krux.rawValue: "https://www.salesforce.com/uk/company/privacy/",
        PrivacyFeature.outbrain.rawValue: "https://www.outbrain.com/legal/privacy#privacy-policy",
        PrivacyFeature.comscore.rawValue: "https://www.comscore.com/About/Privacy-Policy",
        PrivacyFeature.dfp.rawValue: "https://policies.google.com/privacy?hl=en",
        PrivacyFeature.freewheel.rawValue: "https://www.freewheel.com/privacy-policy",
        PrivacyFeature.kochava.rawValue: "https://www.kochava.com/support-privacy/",
        PrivacyFeature.apptentive.rawValue: "https://www.apptentive.com/privacy/",
        PrivacyFeature.conviva.rawValue: "https://www.conviva.com/legal/",
        PrivacyFeature.oneSignal.rawValue: "https://onesignal.com/privacy_policy",
        PrivacyFeature.amazon.rawValue: "https://www.amazon.com/gp/help/customer/display.html/ref=hp_bc_nav?ie=UTF8&nodeId=201909250",
        PrivacyFeature.moat.rawValue: "https://www.oracle.com/legal/privacy/",
        PrivacyFeature.omniture.rawValue: "https://www.adobe.com/uk/privacy.html",
        PrivacyFeature.chartbeat.rawValue: "https://chartbeat.com/privacy/",
        PrivacyFeature.segment.rawValue: "https://segment.com/legal/privacy/",
        PrivacyFeature.vizbee.rawValue: "https://www.vizbee.tv/privacy.html",
        PrivacyFeature.appdynamics.rawValue: "https://www.appdynamics.com/legal/privacy-policy",
        PrivacyFeature.auditude.rawValue: "https://www.adobe.com/privacy/policy.html",
        PrivacyFeature.zion.rawValue: "https://cnn.com/webview/privacy",
        PrivacyFeature.optimizely.rawValue: "https://www.optimizely.com/privacy/",
        PrivacyFeature.prism.rawValue: "https://www.warnermediaprivacy.com/privacy-policy/",
        PrivacyFeature.airship.rawValue: "https://www.airship.com/legal/privacy/"
    ]
    public let purposes: [Int: String] = [
        1: "Store and/or access information on a device",
        3: "Create a personalised ads profile",
        4: "Select personalised ads",
    ]
    public let legPurposes: [Int: String] = [
        2: "Select basic ads",
        5: "Create a personalised content profile",
        6: "Select personalised content",
        7: "Measure ad performance",
        8: "Measure content performance",
        9: "Apply market research to generate audience insights",
        10: "Develop and improve products"
    ]
    public let specialPurposes: [Int: String] = [
        1: "Ensure security, prevent fraud, and debug",
        2: "Technically deliver ads or content"
    ]
    public let features: [Int: String] = [
        1: "Match and combine offline data sources",
        2: "Link different devices",
        3: "Receive and use automatically-sent device characteristics for identification"
    ]
    public let specialFeatures: [Int: String] = [
        1: "Use precise geolocation data",
        2: "Actively scan device characteristics for identification"
    ]
    public func getDefaultSDKDictionary() -> [String: [String: String]] {
        let defaultDict: Dictionary<String, Dictionary<String, String>> = [
            "IABV2_1": [PrivacyFeature.apptentive.rawValue: "Apptentive",
                        PrivacyFeature.conviva.rawValue: "Conviva",
                        PrivacyFeature.oneSignal.rawValue: "One Signal",
                        PrivacyFeature.amazon.rawValue: "Amazon A9",
                        PrivacyFeature.moat.rawValue: "Moat",
                        PrivacyFeature.airship.rawValue: "Airship",
                        PrivacyFeature.omniture.rawValue: "Adobe Omniture",
                        PrivacyFeature.chartbeat.rawValue: "Chartbeat",
                        PrivacyFeature.krux.rawValue: "Krux (Salesforce DMP)",
                        PrivacyFeature.freewheel.rawValue: "Freewheel",
                        PrivacyFeature.outbrain.rawValue: "Outbrain",
                        PrivacyFeature.segment.rawValue: "Segment",
                        PrivacyFeature.zion.rawValue: "Zion",
                        PrivacyFeature.vizbee.rawValue: "Vizbee",
                        PrivacyFeature.dfp.rawValue: "Google Ad Manager",
                        PrivacyFeature.comscore.rawValue: "Comscore",
                        PrivacyFeature.optimizely.rawValue: "Optimizely"],
            "IABV2_2": [PrivacyFeature.amazon.rawValue: "Amazon A9",
                        PrivacyFeature.dfp.rawValue: "Google Ad Manager"],
            "IABV2_3": [PrivacyFeature.amazon.rawValue: "Amazon A9",
                        PrivacyFeature.segment.rawValue: "Segment",
                        PrivacyFeature.krux.rawValue: "Krux (Salesforce DMP)",
                        PrivacyFeature.zion.rawValue: "Zion",
                        PrivacyFeature.dfp.rawValue: "Google Ad Manager"],
            "IABV2_4": [PrivacyFeature.amazon.rawValue: "Amazon A9",
                        PrivacyFeature.segment.rawValue: "Segment",
                        PrivacyFeature.zion.rawValue: "Zion",
                        PrivacyFeature.krux.rawValue: "Krux (Salesforce DMP)",
                        PrivacyFeature.dfp.rawValue: "Google Ad Manager"],
            "IABV2_5": [PrivacyFeature.conviva.rawValue: "Conviva",
                        PrivacyFeature.oneSignal.rawValue: "One Signal",
                        PrivacyFeature.omniture.rawValue: "Adobe Omniture",
                        PrivacyFeature.segment.rawValue: "Segment",
                        PrivacyFeature.airship.rawValue: "Airship",
                        PrivacyFeature.optimizely.rawValue: "Optimizely",
                        PrivacyFeature.zion.rawValue: "Zion"],
            "IABV2_6": [PrivacyFeature.conviva.rawValue: "Conviva",
                        PrivacyFeature.apptentive.rawValue: "Apptentive",
                        PrivacyFeature.oneSignal.rawValue: "One Signal",
                        PrivacyFeature.omniture.rawValue: "Adobe Omniture",
                        PrivacyFeature.optimizely.rawValue: "Optimizely",
                        PrivacyFeature.segment.rawValue: "Segment",
                        PrivacyFeature.airship.rawValue: "Airship",
                        PrivacyFeature.zion.rawValue: "Zion"],
            "IABV2_7": [PrivacyFeature.moat.rawValue: "Moat",
                        PrivacyFeature.segment.rawValue: "Segment",
                        PrivacyFeature.krux.rawValue: "Krux (Salesforce DMP)",
                        PrivacyFeature.optimizely.rawValue: "Optimizely",
                        PrivacyFeature.zion.rawValue: "Zion"],
            "IABV2_8": [PrivacyFeature.conviva.rawValue: "Conviva",
                        PrivacyFeature.apptentive.rawValue: "Apptentive",
                        PrivacyFeature.oneSignal.rawValue: "One Signal",
                        PrivacyFeature.omniture.rawValue: "Adobe Omniture",
                        PrivacyFeature.chartbeat.rawValue: "Chartbeat",
                        PrivacyFeature.optimizely.rawValue: "Optimizely",
                        PrivacyFeature.airship.rawValue: "Airship",
                        PrivacyFeature.krux.rawValue: "Krux (Salesforce DMP)",
                        PrivacyFeature.segment.rawValue: "Segment",
                        PrivacyFeature.zion.rawValue: "Zion"],
            "IABV2_9": [PrivacyFeature.conviva.rawValue: "Conviva",
                        PrivacyFeature.krux.rawValue: "Krux (Salesforce DMP)",
                        PrivacyFeature.omniture.rawValue: "Adobe Omniture"],
            "IABV2_10": [PrivacyFeature.conviva.rawValue: "Conviva",
                         PrivacyFeature.apptentive.rawValue: "Apptentive",
                         PrivacyFeature.omniture.rawValue: "Adobe Omniture"],
            "ISPV2_1": [PrivacyFeature.appdynamics.rawValue: "AppDynamics"],
            "SPD_BG": [PrivacyFeature.comscore.rawValue: "Comscore",
                       PrivacyFeature.kochava.rawValue: "Kochava",
                       PrivacyFeature.amazon.rawValue: "Amazon A9",
                       PrivacyFeature.dfp.rawValue: "Google Ad Manager",
                       PrivacyFeature.outbrain.rawValue: "Outbrain",
                       PrivacyFeature.krux.rawValue: "Krux (Salesforce DMP)",
                       PrivacyFeature.auditude.rawValue: "Adobe Auditude",
                       PrivacyFeature.freewheel.rawValue: "Freewheel"]
        ]
        return defaultDict
    }
    
    public func vendorsOrder(strType: String) -> Int8 {
        switch strType {
        case PrivacyFeature.amazon.rawValue: return 1
        case PrivacyFeature.dfp.rawValue: return 2
        case PrivacyFeature.freewheel.rawValue: return 3
        case PrivacyFeature.comscore.rawValue: return 4
        case PrivacyFeature.kochava.rawValue: return 5
        case PrivacyFeature.outbrain.rawValue: return 6
        default: return 10
        }
    }
    
    /*
     These are the purpose ids that we can get the user consent status by the user
     IABV_1, IAB_3, IAB_4 are the consent purposes
     IAB_2, IAB_4, IAB_6, IAB_8, IAB_9 IAB_10 are legitimate interest purposes
     ISPV is special purpose there is 1 and 2
     IFEV is feature purpose there is 1,2 and 3
     the pruposes that are not included are ISFV2_2 (Scan device characteristics for identification) and ISFV2_1 (Precise geolocation data) and we don't show last two purposes on the screenOTS
     */
    
    public func orderderedPurposesGDPR(strType: String) -> Int8 {
        switch strType {
        case IABV2_1: return 1
        case IABV2_4: return 2
        case IABV2_3: return 3
        case IABV2_6: return 4
        case IABV2_5: return 5
        case IABV2_8: return 6
        case IABV2_9: return 7
        case IABV2_10: return 8
        case IABV2_2: return 9
        case IABV2_7: return 10
        case ISPV2_1: return 11
        case ISPV2_2: return 12
        case IFEV2_1: return 13
        case IFEV2_2: return 14
        case IFEV2_3: return 15
        case "req": return 16
        default: return -1
        }
    }
    
    func purposeShouldBeIncluded(groupId: String, isGDPR: Bool) -> Bool {
        if (isGDPR && (groupId.starts(with: "IAB") || groupId == "ISPV2_1" || groupId == "req")) ||
            (!isGDPR && groupId.contains("BG")) {
            return true
        }
        return false
    }
    
    func attachIndex(groupId: String, isGDPR: Bool) -> Int8 {
        if isGDPR {
            return orderderedPurposesGDPR(strType: groupId)
        }
        return 1
    }
}


extension OTPublishersHeadlessSDK {
    
    func updateConsentAndLegPurpose(id: String, status:Bool) {
        let consentPurposes = ["IABV2_1", "IABV2_3", "IABV2_4","SPD_BG"]
        if consentPurposes.contains(id) {
            self.updatePurposeConsent(forGroup: id, consentValue: status)
        } else {
            self.updatePurposeLegitInterest(forGroup: id, legIntValue: status)
        }
    }
    
    func getTransactionStatusAsString(id: String, utils: Utils) -> String {
        let consentPurposes = ["IABV2_1", "IABV2_3", "IABV2_4","SPD_BG"]
        if consentPurposes.contains(id) {
            return self.getConsentStatus(forCategory: id) != 0 ? "active" : "withdrawn"
        } else {
            return self.getPurposeLegitInterestLocal(forCustomGroupId: id) != 0 ? "active" : "withdrawn"
        }
    }
    
    func getTransactionStatusAsInt(id: String, utils: Utils) -> Int8 {
        let consentPurposes = ["IABV2_1", "IABV2_3", "IABV2_4","SPD_BG"]
        if consentPurposes.contains(id) {
            return self.getConsentStatus(forCategory: id) != 0 ? 1 : 0
        } else {
            return self.getPurposeLegitInterestLocal(forCustomGroupId: id) != 0 ? 1 : 0
        }
    }
    
    func shouldOptInOrShouldOptOut(purpose: Group) {
        if purpose.transactionStatus == .ACTIVE {
            self.optIntoSaleOfData()
            self.updatePurposeConsent(forGroup: purpose.CustomGroupId, consentValue: true)
            self.saveConsent(type: .preferenceCenterAllowAll)
        } else {
            self.optOutOfSaleOfData()
            self.updatePurposeConsent(forGroup: purpose.CustomGroupId, consentValue: false)
            self.saveConsent(type: .preferenceCenterRejectAll)
        }
    }
}
