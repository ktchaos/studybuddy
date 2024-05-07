//
//  MainFactory.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 05/05/24.
//

import UIKit

enum MainFactory {
    static func make() -> NavigationCoordinator {
        let viewController = MainViewController()
        let coordinator = RoutinesCoordinator()
        let presenter = MainPresenter(coordinator: coordinator)
        let interactor = MainInteractor(presenter: presenter)

        viewController.interactor = interactor
        presenter.viewController = viewController
        coordinator.start(viewController: viewController)

        return coordinator
    }
}
