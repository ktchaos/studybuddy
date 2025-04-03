//
//  ShieldManager.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 31/03/25.
//

import FamilyControls
import ManagedSettings
import DeviceActivity
import Foundation

final class ShieldManager {
    static let shared = ShieldManager()
    
    var discouragedSelections = FamilyActivitySelection()
    var applicationProfile: ApplicationProfile!
    
    private let store = ManagedSettingsStore()
    
    func shieldActivities() {
        store.clearAllSettings()
        
        let applications = discouragedSelections.applicationTokens
        let categories = discouragedSelections.categoryTokens
        
        store.shield.applications = applications.isEmpty ? nil : applications
        store.shield.applicationCategories = categories.isEmpty ? nil : .specific(categories)
        store.shield.webDomainCategories = categories.isEmpty ? nil : .specific(categories)
    }
    
    func unlockActivities() {
        store.shield.applications?.removeAll()
    }
}
