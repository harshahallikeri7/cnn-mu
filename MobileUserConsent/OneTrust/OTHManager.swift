//
//  OTHManager.swift
//  CNNPrivacy
//
//  Created by alaa alshammari on 7/17/20.
//

import Foundation
import AdSupport
//import OTPublishersHeadlessSDKtvOS
#if os(tvOS)
import OTPublishersHeadlessSDKtvOS
#else
import OTPublishersHeadlessSDK
#endif

//class OneTrustFailure: Error {}

class OTHManager: NSObject {
    private var muConfig: MUConfig
    private var otHeadless: OTPublishersHeadlessSDK
    private var utils: Utils
    private var _privacyData: PrivacyData
    public var privacyData:PrivacyData {
        get { return _privacyData }
    }
    
    public var isSubjectToCCPA = false
    public var isSubjectToGDPR = false
    public var showConsentScreen: Bool = false
    private var undeterminedCCPAConsentString = "1NYN"
    
    public struct TimeOutError: Error {}
    public var vendorController:VendorController
    
    init(config: MUConfig, completion: @escaping (Error?) -> ()) {
        muConfig = config
        utils = Utils()
        otHeadless = OTPublishersHeadlessSDK.shared
        _privacyData = PrivacyData(pList: [])
        vendorController = VendorController(otsdk: otHeadless)
        super.init()
        initOTData(completion: completion)
    }
    
    private func initOTData(completion: @escaping (Error?) -> Void) {
        //let params = OTSdkParams(countryCode: "us", regionCode: "ca")
        
        otHeadless.startSDK(storageLocation: muConfig.oneTrustUrl,
                            domainIdentifier: muConfig.oneTrustId,
                            languageCode: muConfig.language) {
            
            [weak self ] (result) in
            
            if let error = result.error {
                print("\(error.localizedDescription)")
                print (error)
                completion(OneTrustFailure())
                return
            }
            
            let jsonDec = OneTrustDecoder()
            let oneTrustObj:OneTrustData
            do {
                if let self = self,
                   let raw = result.responseString,
                   let rawData = raw.data(using: .utf8)
                {
                    oneTrustObj = try jsonDec.decode(OneTrustData.self, from: rawData)
                    self._privacyData = PrivacyData(pList: oneTrustObj.culture.DomainData.Groups)
                    
                    for purpose in self._privacyData.purposesList {
                        self.updateTransactionStatus(purpose: purpose)
                    }
                    
                    let ruleType = oneTrustObj.domain.ruleDetails.name
                    //global == Global // CCPA == CCPA // EU == GDPR new
                    self.isSubjectToCCPA = ruleType == "CCPA"
                    self.isSubjectToGDPR = ruleType.contains("GDPR")
                }
            } catch let err {
                if let error = result.error {
                    print("\(error.localizedDescription)")
                }
                print (err)
                completion(OneTrustFailure())
                return
            }
            
            
            guard let self = self else { return }
            self.publishSavedData(completion: completion)
        }
    }
    
    func updateTransactionStatus(purpose:Group) {
        if (purpose.Status == "always active") {
            purpose.transactionStatus = .ALWAYS_ACTIVE
            return
        }
        
        let val:Int8
        if purpose.HasConsentOptOut {
            val = otHeadless.getConsentStatus(forCategory: purpose.CustomGroupId)
            print("fetched consent value of " + String(val) + " for " + purpose.CustomGroupId)
        } else if purpose.HasLegIntOptOut {
            val = otHeadless.getPurposeLegitInterestLocal(forCustomGroupId: purpose.CustomGroupId)
            print("fetched legitInterest value of " + String(val) + " for " + purpose.CustomGroupId)
        } else {
            val = -1
            print("no fetchable value for " + purpose.CustomGroupId)
        }
        
        if val == -1 {
            purpose.transactionStatus = .UNDEFINED
        } else if (val == 1) {
            purpose.transactionStatus = .WITHDRAWN
        } else {
            purpose.transactionStatus = .ACTIVE
        }
    }
    
    // TCF 2.0 has the concept of consent group and Legitimate Interest group. Consent groups means
    // user have to provide explict consent and Legitimate Interest group means it can start with default as true.
    // Consent groups are purposes 1,3 and 4 and Legitimate Interest group are 2,5,6,7,8,9 and 10.
    // OT SDK 6.6 has a bug which necessitates a need to call two separate APIs for getting consent
    // or saving consent. This is not needed in previous versions.
    
    private func publishSavedData(completion: @escaping (Error?) -> Void){
        if self.otHeadless.getVendorListData() == nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                self.publishData(completion: completion)
            })
        } else {
            self.publishData(completion: completion)
        }
        
    }
    
    private func publishData(completion: @escaping (Error?) -> Void) {
        //let allVendors = vendorController.getAllVendors()
        /*for category in groups {
         guard utils.purposeShouldBeIncluded(groupId: category.CustomGroupId, isGDPR: isSubjectToGDPR) else { continue }
         
         let vendors: [Vendor] = allVendors.filter({ (ven) -> Bool in utils.getDefaultSDKDictionary()[category.CustomGroupId]?.keys.contains(ven.name) ?? false
         })
         
         purposes.append(category)
         }
         */
        showConsentScreen = self.otHeadless.shouldShowBanner()
        
        //_privacyData.vendors = allVendors
        //idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        
        //let uspstr = getUSPString()
        //let iabstr = getIABValues()
        
        completion(nil)
    }
    
    public func updateAllPurposes(consent:Bool) {
        if (consent) {
            otHeadless.optIntoSaleOfData()
        } else {
            otHeadless.optOutOfSaleOfData()
        }
        
        for purpose in privacyData.purposesList {
            shouldOptInOrShouldOptOut(purpose: purpose, consent: consent)
        }
        
        if (consent) {
            otHeadless.saveConsent(type: .preferenceCenterAllowAll)
        } else {
            otHeadless.saveConsent(type: .preferenceCenterRejectAll)
        }
        
        for purpose in self._privacyData.purposesList {
            self.updateTransactionStatus(purpose: purpose)
        }
    }
    
    func shouldOptInOrShouldOptOut(purpose: Group, consent: Bool) {
        if (purpose.transactionStatus != .ALWAYS_ACTIVE && purpose.transactionStatus != .UNDEFINED) {
            let groupStatus:GroupStatus = (consent) ? .ACTIVE : .WITHDRAWN
            purpose.transactionStatus = groupStatus
            print("update consent status of " + purpose.CustomGroupId)
            
            if (purpose.HasConsentOptOut) {
                otHeadless.updatePurposeConsent(forGroup: purpose.CustomGroupId, consentValue: consent)
            }
            
            if (purpose.HasLegIntOptOut) {
                otHeadless.updatePurposeLegitInterest(forGroup: purpose.CustomGroupId, legIntValue: consent)
            }
        }
    }
    
    public func getIabVendors() -> [String] {
        return utils.iabVendors
    }
    
    public func getUSPBool() -> Bool {
        let venGroup = privacyData.purposeIndex["ven"]
        return venGroup?.transactionStatus == .ACTIVE
    }
    
    public func getUSPString() -> String {
        let ccpaString = UserDefaults.standard.string(forKey:"IABUSPrivacy_String")
        return ccpaString ?? "1YNN"
    }
    
    public func getUSPObject() -> MUUSPObject? {
        let uspString = getUSPString()
        return MUUSPObject(uspString: uspString,
                           versionNumber: Bundle.VersionNumber ?? "1.0",
                           comscoreValue: MUPrivacyUtils.getComScoreForUsp(usp: uspString))
    }
    
    public func getIABValues() -> [String: Any] {
        var ret = [String:Any?]()
        for key in [OTIABTCFKeys.iabTcf2AddtlConsent, OTIABTCFKeys.iabTcf2CmpSdkId, OTIABTCFKeys.iabTcf2CmpSdkVersion,
                    OTIABTCFKeys.iabTcf2GdprApplies, OTIABTCFKeys.iabTcf2PolicyVersion, OTIABTCFKeys.iabTcf2PublisherCC,
                    OTIABTCFKeys.iabTcf2PublisherConsent, OTIABTCFKeys.iabTcf2PublisherCustomPurposesConsents,
                    OTIABTCFKeys.iabTcf2PublisherCustomPurposesLegitimateInterests,
                    OTIABTCFKeys.iabTcf2PublisherLegitimateInterests, OTIABTCFKeys.iabTcf2PublisherRestrictions,
                    OTIABTCFKeys.iabTcf2PurposeConsents, OTIABTCFKeys.iabTcf2PurposeLegitimateInterests,
                    OTIABTCFKeys.iabTcf2PurposeOneTreatment, OTIABTCFKeys.iabTcf2SpecialFeaturesOptIns,
                    OTIABTCFKeys.iabTcf2TCString, OTIABTCFKeys.iabTcf2UseNonStandardStacks, OTIABTCFKeys.iabTcf2VendorConsents,
                    OTIABTCFKeys.iabTcf2VendorLegitimateInterests
        ] {
            guard let savedValue = UserDefaults.standard.value(forKey: key) else {
                ret[key] = nil
                continue
            }
            
            if savedValue is Int {
                ret[key] = String(savedValue as! Int)
            } else if savedValue is String {
                ret[key] = String(savedValue as! String)
            } else {
                ret[key] = savedValue
            }
        }
        
        return ret as [String: Any]
    }
    
    func getVendorState(vendorId: String) -> Bool {
        return vendorController.getVendorStatus(vendor: vendorId)
    }
    
    func setVendorState(vendorId: String, consentValue: Bool) {
        vendorController.setConsentStatus(vendorId: vendorId, consentValue: consentValue)
    }
}

extension Optional {
    func `let`(do: (Wrapped)->()) {
        guard let v = self else { return }
        `do`(v)
    }
}
