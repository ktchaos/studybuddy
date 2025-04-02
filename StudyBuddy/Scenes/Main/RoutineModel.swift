//
//  RoutineModel.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 05/05/24.
//

import Foundation
import ManagedSettings
import FamilyControls

struct Routine: Codable {
    var title: String
    var description: String
    var numberOfSessions: Int
    var audio: Audio
    var blockedApps: FamilyActivitySelection
    var rangeTime: String

    init(
        title: String = "",
        description: String = "",
        rangeTime: String = "",
        numberOfSessions: Int = 0,
        audio: Audio = Audio(path: "", type: ""),
        blockedApps: FamilyActivitySelection = .init()
    ) {
        self.title = title
        self.description = description
        self.rangeTime = rangeTime
        self.numberOfSessions = numberOfSessions
        self.audio = audio
        self.blockedApps = blockedApps
    }
}

extension Routine: Equatable {
    static func == (lhs: Routine, rhs: Routine) -> Bool {
        return (lhs.title == rhs.title && lhs.description == rhs.description)
    }
}

struct Audio: Codable {
    let path: String
    let type: String
}
