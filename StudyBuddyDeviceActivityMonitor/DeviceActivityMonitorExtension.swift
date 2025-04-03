//
//  DeviceActivityMonitorExtension.swift
//  StudyBuddyDeviceActivityMonitor
//
//  Created by Catarina Serrano on 31/03/25.
//

import DeviceActivity
import Foundation
import ManagedSettings

// Optionally override any of the functions below.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        // Handle the end of the interval.
        let database = DataBase()
        guard let activityId = UUID(uuidString: activity.rawValue) else { return }
        guard let application = database.getApplicationProfile(id: activityId) else { return }
        let store = ManagedSettingsStore()
        store.shield.applications?.insert(application.applicationToken)
        database.removeApplicationProfile(application)
    }
}
