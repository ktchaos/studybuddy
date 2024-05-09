//
//  ProfilePresenter.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 05/05/24.
//

import UIKit

protocol ProfilePresenting {
    var viewController: ProfileViewControlling? { get set }

    func goToRankingScreen()
    func goToHelpScreen()
    func displayTotalSBPoints(with totalPoints: Double)
    func displayProfilePicture(with picture: UIImage)
}

final class ProfilePresenter: ProfilePresenting {
    private let coordinator: ProfileCoordinator
    var viewController: ProfileViewControlling?

    init(coordinator: ProfileCoordinator) {
        self.coordinator = coordinator
    }
}

extension ProfilePresenter {
    func goToRankingScreen() {
        coordinator.presentRankingScreen()
    }

    func goToHelpScreen() {
        coordinator.presentHelpScreen()
    }

    func displayTotalSBPoints(with totalPoints: Double) {
        let totalPointsText = "\(totalPoints) SB Points"
        viewController?.updateTotalPointsLabel(with: totalPointsText)
    }

    func displayProfilePicture(with picture: UIImage) {
        viewController?.updateProfilePicture(with: picture)
    }
}
