//
//  RoutineModel.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 05/05/24.
//

import Foundation
import ManagedSettings

struct Routine: Codable {
    var title: String
    var description: String
    var numberOfSessions: Int
    var audio: Audio
    var blockedApps: [BlockedApplication]
    var rangeTime: String

    init(
        title: String = "",
        description: String = "",
        rangeTime: String = "",
        numberOfSessions: Int = 0,
        audio: Audio = Audio(path: "", type: ""),
        blockedApps: [BlockedApplication] = []
    ) {
        self.title = title
        self.description = description
        self.rangeTime = rangeTime
        self.numberOfSessions = numberOfSessions
        self.audio = audio
        self.blockedApps = blockedApps
    }
}

struct Audio: Codable {
    let path: String
    let type: String
}

struct BlockedApplication: Codable {
    let token: String
    let bundleId: String
}
