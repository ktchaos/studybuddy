//
//  NewUserPresenter.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 05/05/24.
//

protocol NewUserPresenting {
    var viewController: NewUserViewControlling? { get set }

    func displayError(with message: String)
    func goToOnboardingScreen(with username: String)
}

class NewUserPresenter: NewUserPresenting {
    var viewController: NewUserViewControlling?
    private let coordinator: NewUserCoordinator

    init(coordinator: NewUserCoordinator) {
        self.coordinator = coordinator
    }
}

extension NewUserPresenter {
    func displayError(with message: String) {
        viewController?.displayError(with: message)
    }

    func goToOnboardingScreen(with username: String) {
        coordinator.presentOnboardingScreen(with: username)
    }
}
