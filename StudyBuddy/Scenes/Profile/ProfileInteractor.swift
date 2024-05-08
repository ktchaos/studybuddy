//
//  ProfileInteractor.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 05/05/24.
//

import Foundation

struct User {
    var username: String
    var points: Double
}

protocol ProfileInteracting {
    func onRankingTap()
    func onHelpTap()

    func getUsernameAndLoadPoints() -> String
    func loadTotalSBPoints()
}

final class ProfileInteractor: ProfileInteracting {
    private let presenter: ProfilePresenting

    let userDefaults = UserDefaults.standard
    private let usernameKey: String = "username"
    private let pointsKey: String = "points"
    private let user: User

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
        guard let name = userDefaults.string(forKey: usernameKey) else { return "" }
        return "@\(name)"
    }

    func loadTotalSBPoints() {
        let totalPoints = userDefaults.double(forKey: pointsKey)
        presenter.displayTotalSBPoints(with: totalPoints)
    }
}
