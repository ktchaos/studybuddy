//
//  ProfileFactory.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 05/05/24.
//

import Foundation

enum ProfileFactory {
    static func make() -> NavigationCoordinator {
        let viewController = ProfileViewController()
        let coordinator = ProfileCoordinator()
        let presenter = ProfilePresenter(coordinator: coordinator)
        let interactor = ProfileInteractor(presenter: presenter)

        viewController.interactor = interactor
        coordinator.start(viewController: viewController)
        presenter.viewController = viewController

        return coordinator
    }
}
