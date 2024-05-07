//
//  RoutineDetailsCoordinator.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 06/05/24.
//

import UIKit

class RoutinesDetailsCoordinator: NavigationCoordinator {
    var isCompleted: (() -> Void)?
    var rootViewController: UINavigationController
    var childCoordinators = [Coordinator]()
    var delegate: RoutinesCoordinatorDelegate?

    init() {
        self.rootViewController = UINavigationController()
    }

    func start(viewController: UIViewController) {
        self.rootViewController.viewControllers = [viewController]
    }

    func start() {}

    func presentPomodoroAndSoundScreen(model: Routine) {
        delegate?.presentPomodoroAndSoundScreen(model: model)
    }
}
