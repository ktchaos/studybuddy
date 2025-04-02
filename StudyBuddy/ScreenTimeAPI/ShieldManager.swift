//
//  ShieldManager.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 31/03/25.
//

import FamilyControls
import ManagedSettings

final class ShieldManager {
    static let shared = ShieldManager()
    
    var discouragedSelections = FamilyActivitySelection()
    
    private let store = ManagedSettingsStore()
    
    func shieldActivities() {
        // Clear to reset previous settings
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
