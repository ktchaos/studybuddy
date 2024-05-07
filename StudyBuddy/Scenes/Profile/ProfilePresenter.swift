//
//  ProfilePresenter.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 05/05/24.
//

protocol ProfilePresenting {
    var viewController: ProfileViewControlling? { get set }

    func goToRankingScreen()
    func goToHelpScreen()
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
}
