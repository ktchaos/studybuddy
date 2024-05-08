//
//  PomodoroAndSoundCoordinator.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 06/05/24.
//

import UIKit

class PomodoroAndSoundCoordinator: NavigationCoordinator {
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

    func dismissScreen() {
        delegate?.dismissPomodoroAndSoundScreen()
    }
}
