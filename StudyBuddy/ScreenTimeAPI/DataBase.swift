//
//  DataBase.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 02/04/25.
//

import Foundation

struct DataBase {
    private let defaults = UserDefaults(suiteName: "group.com.chaos.StudyBuddy.data")
    private let applicationProfileKey = "ApplicationProfile"
    
    func getApplicationProfiles() -> [UUID: ApplicationProfile] {
        guard let data = defaults?.data(forKey: applicationProfileKey) else { return [:] }
        guard let decoded = try? JSONDecoder().decode([UUID: ApplicationProfile].self, from: data) else { return [:] }
        return decoded
    }
    
    func getApplicationProfile(id: UUID) -> ApplicationProfile? {
        return getApplicationProfiles()[id]
    }
    
    func addApplicationProfile(_ application: ApplicationProfile) {
        var applications = getApplicationProfiles()
        applications.updateValue(application, forKey: application.id)
        saveApplicationProfiles(applications)
    }
    
    func saveApplicationProfiles(_ applications: [UUID: ApplicationProfile]) {
        guard let encoded = try? JSONEncoder().encode(applications) else { return }
        defaults?.set(encoded, forKey: applicationProfileKey)
    }
    
    func removeApplicationProfile(_ application: ApplicationProfile) {
        var applications = getApplicationProfiles()
        applications.removeValue(forKey: application.id)
        saveApplicationProfiles(applications)
    }
}
