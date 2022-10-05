//
//  VendorController.swift
//  CNNPrivacy
//
//  Created by alaa alshammari on 10/27/20.
//  Copyright © 2020 CNN. All rights reserved.
//
//import OTPublishersHeadlessSDKtvOS
#if os(tvOS)
import OTPublishersHeadlessSDKtvOS
#else
import OTPublishersHeadlessSDK
#endif
import Foundation

public class VendorController: NSObject {
    var otPublisherSDK:OTPublishersHeadlessSDK
    var utils:Utils = Utils()
    public init(otsdk: OTPublishersHeadlessSDK) {
        otPublisherSDK = otsdk
    }
    
    func getAllVendors() -> [Vendor]{
        var vendorsList:[Vendor] = []
        let json = otPublisherSDK.getVendorListData()
        for vendor in utils.privacyLinks.keys {
            var iabVendor: IABVendor? = nil
            if utils.iabVendors.contains(vendor) {
                if json != nil {
                    do {
                        guard let vendorData = try? JSONSerialization.data(
                            withJSONObject: json?[utils.iabVendorsIdMap[vendor] ?? "" ] as Any,
                            options: []) else { continue }
                        iabVendor =  try JSONDecoder().decode(IABVendor.self, from: vendorData)
                    } catch let decodeErr {
                        print("Failed to decode:", decodeErr)
                    }
                }
            }
            vendorsList.append(
                Vendor(
                    name: vendor,
                    policyUrl: utils.privacyLinks[vendor] ?? "",
                    purposes: utils.convertPurposesFromIntsToStrings(intPurposes: iabVendor?.purposes, targetDic: utils.purposes),
                    legPurposes: utils.convertPurposesFromIntsToStrings(intPurposes: iabVendor?.legIntPurposes, targetDic: utils.legPurposes),
                    specialPurposes: utils.convertPurposesFromIntsToStrings(intPurposes: iabVendor?.specialPurposes, targetDic: utils.specialPurposes),
                    features: utils.convertPurposesFromIntsToStrings(intPurposes: iabVendor?.features, targetDic: utils.features),
                    specialFeatures: utils.convertPurposesFromIntsToStrings(intPurposes: iabVendor?.specialFeatures, targetDic: utils.specialFeatures),
                    isIab: utils.iabVendorsIdMap.keys.contains(vendor),
                    consentStatus: iabVendor?.consent == 1,
                    objectToLeg: iabVendor?.legIntPurposes?.count != 0 && iabVendor?.legIntStatus == 0,
                    index: utils.vendorsOrder(strType: vendor)
                )
            )
        }
        return vendorsList
    }
    
    func getVendorStatus(vendor: String) -> Bool {
        var vendorStatus = true
        var consentStatus = true
        var objectToLeg = false
        guard let json = otPublisherSDK.getVendorListData() else { return true}
        guard let vendorData = try? JSONSerialization.data(
            withJSONObject: json[utils.iabVendorsIdMap[vendor] ?? "" ] as Any,
            options: []) else { return true }
        do {
            let iabVendor: IABVendor =  try JSONDecoder().decode(IABVendor.self, from: vendorData)
            if iabVendor.consent != -1 {
                consentStatus = iabVendor.consent == 1
            }
            if iabVendor.legIntPurposes?.count != 0 {
                objectToLeg = iabVendor.legIntStatus == 0
            }
            vendorStatus = consentStatus && !objectToLeg
        } catch let error {
            print("VendorStatusNow \(error)")
            return vendorStatus
        }
        return vendorStatus
    }
    
    func setConsentStatus(vendorId: String, consentValue: Bool) {
        otPublisherSDK.updateVendorConsent(vendorID: vendorId, consentStatus: consentValue)
    }
    
    func consentToAllVendors() {
        guard let json = otPublisherSDK.getVendorListData() else { return }
        for ven in utils.iabVendorsIdMap.values {
            guard let vendorData = try? JSONSerialization.data(
                withJSONObject: json[ven ] as Any,
            options: []) else { continue }
            do {
                let iabVendor: IABVendor =  try JSONDecoder().decode(IABVendor.self, from: vendorData)
                if ven.isEmpty == false {
                    otPublisherSDK.updateVendorConsent(vendorID: ven, consentStatus: true)
                    if(iabVendor.legIntPurposes?.count != 0) {
                        otPublisherSDK.updateVendorLegitInterest(vendorID: ven, legIntStatus: true)
                    }
                }
            } catch let error {
                print("VendorStatusNow \(error.localizedDescription)")
            }
        }
        otPublisherSDK.saveConsent(type: .appTrackingOptOut)
    }
    
    func saveVendorsConsent(vendors: [Vendor]) {
        vendors.forEach { ven in
            let id: String? = utils.iabVendorsIdMap[ven.name]
            if id?.isEmpty == false {
                otPublisherSDK.updateVendorConsent(vendorID: id ?? "", consentStatus: ven.consentStatus)
                if(ven.legPurposes.count != 0) {
                    otPublisherSDK.updateVendorLegitInterest(vendorID: id ?? "", legIntStatus: !ven.objectToLeg)
                }
            }
        }
    }
}
