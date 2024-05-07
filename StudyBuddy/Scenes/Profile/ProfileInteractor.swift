//
//  ProfileInteractor.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 05/05/24.
//

protocol ProfileInteracting {
    func onRankingTap()
    func onHelpTap()
}

final class ProfileInteractor: ProfileInteracting {
    private let presenter: ProfilePresenting

    init(presenter: ProfilePresenting) {
        self.presenter = presenter
    }
}

extension ProfileInteractor {
    func onRankingTap() {
        presenter.goToRankingScreen()
    }

    func onHelpTap() {
        presenter.goToHelpScreen()
    }
}
