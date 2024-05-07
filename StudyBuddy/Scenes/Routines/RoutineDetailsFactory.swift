//
//  RoutineDetailsFactory.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 06/05/24.
//

import UIKit

enum RoutineDetailsFactory {
    static func make(model: Routine, delegate: RoutinesCoordinatorDelegate) -> UIViewController {
        let coordinator = RoutinesDetailsCoordinator()
        let viewController = RoutineDetailsViewController()
        let presenter = RoutineDetailsPresenter(coordinator: coordinator)
        let interactor = RoutineDetailsInteractor(presenter: presenter, model: model)

        presenter.viewController = viewController
        viewController.interactor = interactor
        coordinator.delegate = delegate
        coordinator.start(viewController: viewController)

        return viewController
    }
}
