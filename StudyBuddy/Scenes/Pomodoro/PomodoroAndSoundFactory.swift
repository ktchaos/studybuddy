//
//  PomodoroAndSoundFactory.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 06/05/24.
//

import UIKit

enum PomodoroAndSoundFactory {
    static func make(model: Routine, delegate: RoutinesCoordinatorDelegate) -> UIViewController {
        let coordinator = PomodoroAndSoundCoordinator()
        let viewController = PomodoroAndSoundViewController()
        let presenter = PomodoroAndSoundPresenter(coordinator: coordinator)
        let interactor = PomodoroAndSoundInteractor(presenter: presenter, routine: model)

        coordinator.delegate = delegate
        viewController.interactor = interactor
        presenter.viewController = viewController
        coordinator.start(viewController: viewController)

        return viewController
    }
}
