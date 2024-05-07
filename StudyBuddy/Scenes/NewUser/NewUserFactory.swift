//
//  NewUserFactory.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 05/05/24.
//

import UIKit

enum NewUserFactory {
    static func make() -> (UIViewController, NavigationCoordinator) {
        let coordinator = NewUserCoordinator()
        let presenter = NewUserPresenter(coordinator: coordinator)
        let interactor = NewUserInteractor(presenter: presenter)
        let viewController = NewUserViewController()

        viewController.interactor = interactor
        presenter.viewController = viewController

        coordinator.start(viewController: viewController)
        return (viewController, coordinator)
    }
}
