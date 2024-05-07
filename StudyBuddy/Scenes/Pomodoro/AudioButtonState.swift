//
//  AudioButtonState.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 07/05/24.
//

import UIKit

enum AudioButtonState {
    case playing
    case paused
    case idle

    var image: UIImage? {
        switch self {
        case .idle, .paused:
            return UIImage(systemName: "play.circle.fill")
        case .playing:
            return UIImage(systemName: "pause.circle.fill")
        }
    }
}
