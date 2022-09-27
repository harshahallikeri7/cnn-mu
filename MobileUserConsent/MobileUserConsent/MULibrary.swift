//   ExternalContracts.swift
//  MobileUserConsent



import Foundation


@objc
public class MULibrary: NSObject {
    
    private var oneTrustManager: OTHManager?
    
    @objc public enum CallbackStatus:Int {
        public typealias RawValue = Int
        case SUCCESS = 1
        case FAIL = 2
    }
    
    /*******************************************************
    * Initialization of MU Library
    *******************************************************/
    @objc
    public func muInit(muConfig: MUConfig, callback: @escaping (CallbackStatus) -> ()) {
        oneTrustManager = OTHManager(config: muConfig, completion: { (error) in
            if error != nil {
                callback(.FAIL)
            } else {
                callback(.SUCCESS)
            }
        })
    }
    
    /*******************************************************
    * Returns USP string
    *******************************************************/
    @objc
    public func muGetUSPString() -> String {
        return oneTrustManager?.getUSPString() ?? "1---"
    }
    
    /*******************************************************
    * Returns Bool value of USP
    *******************************************************/
    @objc
    public func muGetUSPBool() -> Bool {
        return oneTrustManager?.getUSPBool() ?? false
    }
    
    /*******************************************************
    * Returns Privacy data
    *******************************************************/
    @objc
    public func muGetUSPObject() -> MUUSPObject? {
        oneTrustManager?.getUSPObject()
    }
    
   /*******************************************************
    * Returns Vendor consent value
    *******************************************************/
    @objc
    public func mGetVendorState(vendorId: String) -> Bool {
        return oneTrustManager?.getVendorState(vendorId: vendorId) == true
    }
    
    /*******************************************************
    * Returns Set vendor consent value
    *******************************************************/
    @objc
    public func muSetVendorState(vendorId: String, isOpenToDataSharing: Bool) {
    }
}
