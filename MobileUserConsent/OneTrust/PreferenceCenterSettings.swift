//
//  PreferenceCenterSettings.swift
//  CNNPrivacy
//
//  Created by Massimiliano Petrucci on 8/24/18.
//

import Foundation

public struct PreferenceCenterSettings: Codable {
    let Title: String
    let ChangePreferencesLabel: String?
    let UnsubscribeAllLabel: String?
    let UnsubscribeSuccessLabel: String?
    let UpdateErrorLabel: String?
    let UpdateSuccessLabel: String?
    var WelcomeMessage: String?
    public init(pr: PreferenceSettings) {
        self.Title = pr.title
        self.ChangePreferencesLabel = pr.changePreferencesLabel
        self.UnsubscribeAllLabel = pr.unsubscribeAllLabel
        self.UnsubscribeSuccessLabel = pr.unsubscribeSuccessLabel
        self.UpdateErrorLabel = pr.updateErrorLabel
        self.UpdateSuccessLabel = pr.updateSuccessLabel
        self.WelcomeMessage = pr.welcomeMessage.replacingOccurrences(of: "</p><p>", with: "</p><br><p>")
    }
}
