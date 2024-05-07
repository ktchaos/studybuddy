//
//  RoutineModel.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 05/05/24.
//

import Foundation

struct Routine {
    var title: String
    var description: String
    var rangeTime: String // ????
    var numberOfSessions: Int
    var audio: Audio
}

struct Audio {
    let path: String
}
