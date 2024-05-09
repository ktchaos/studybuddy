//
//  ProfileInteractor.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 05/05/24.
//

import Foundation
import UIKit

struct User {
    var username: String
    var points: Double
}

struct ProfilePicture {
    let systemName: String
    let image: UIImage?
}

protocol ProfileInteracting {
    func onRankingTap()
    func onHelpTap()

    func getUsernameAndLoadPoints() -> String
    func loadTotalSBPoints()
    func saveUserImage(_ profilePicture: ProfilePicture)
}

final class ProfileInteractor: ProfileInteracting {
    private let presenter: ProfilePresenting
    private let user: User

    let userDefaults = UserDefaults.standard
    private let usernameKey: String = "username"
    private let pointsKey: String = "points"
    private let profileImageKey: String = "profilepicture"

    init(presenter: ProfilePresenting) {
        self.presenter = presenter
        self.user = User(
            username: userDefaults.string(forKey: usernameKey) ?? "",
            points: userDefaults.double(forKey: pointsKey) 
        )
    }
}

extension ProfileInteractor {
    func onRankingTap() {
        presenter.goToRankingScreen()
    }

    func onHelpTap() {
        presenter.goToHelpScreen()
    }

    func getUsernameAndLoadPoints() -> String {
        loadTotalSBPoints()
        loadProfilePicture()
        guard let name = userDefaults.string(forKey: usernameKey) else { return "" }
        return "@\(name)"
    }

    func loadTotalSBPoints() {
        let totalPoints = userDefaults.double(forKey: pointsKey)
        presenter.displayTotalSBPoints(with: totalPoints)
    }

    func loadProfilePicture() {
        if let path = userDefaults.string(forKey: profileImageKey) {
            presenter.displayProfilePicture(with: UIImage(systemName: path) ?? UIImage())
        }
    }

    func saveUserImage(_ profilePicture: ProfilePicture) {
        userDefaults.set(profilePicture.systemName, forKey: profileImageKey)
    }
}
