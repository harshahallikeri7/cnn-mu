//
//  PrivacyData.swift
//  CNNPrivacy
//
//  Created by Massimiliano Petrucci on 8/24/18.
//

import Foundation

@objc public class PrivacyData: NSObject, Codable {
    public init(pList: [Group]) {
    super.init()
    self.purposesList = pList
    }
    
    private var _purposesList:[Group] = []
    @objc public var purposesList: [Group] {
    get{ return _purposesList }
    set {
        _purposesList = newValue
        purposeIndex = [String:Group]()
        indexPurposes()
    }
    }
    
    @objc public func purposeListToJSON() -> NSString? {
    let enc = JSONEncoder()
    do {
        let retData = try enc.encode(_purposesList)
        let ret = NSString.init(data: retData, encoding: String.Encoding.utf8.rawValue)
        return ret
    } catch { return nil }
    }
    
    @objc public func toJSON() -> NSString? {
    let enc = JSONEncoder()
    do {
        let retData = try enc.encode(self)
        let ret = NSString.init(data: retData, encoding: String.Encoding.utf8.rawValue)
        return ret
    } catch { return nil}
    }
    
    @objc public var purposeIndex = [String: Group]()
    @objc public var rootNodes = Set<Group>()
    @objc public var childrenIndex = [String: [Group]]()
    @objc public var vendors: [Vendor] = []
    
    private func indexPurposes() {
    purposeIndex = [String:Group]()
    
    for purpose in _purposesList {
        purposeIndex[purpose.CustomGroupId] = purpose
    }
    
    for purpose in _purposesList {
        if (purpose.Parent == "") {
        continue
        }
        
        if let parent = purposeIndex[purpose.Parent] {
        if (childrenIndex[parent.CustomGroupId] == nil) {
            childrenIndex[parent.CustomGroupId] = []
            rootNodes.insert(parent)
        }
        
        childrenIndex[parent.CustomGroupId]?.append(purpose)
        } else {
        print("purpose " + purpose.Parent + " not defined in group list")
        }
    }
    }
}
