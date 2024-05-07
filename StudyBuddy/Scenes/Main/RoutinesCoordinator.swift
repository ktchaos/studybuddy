//
//  RoutinesCoordinator.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 23/04/24.
//

import Foundation
import UIKit

protocol RoutinesCoordinatorDelegate {
    func presentPomodoroAndSoundScreen(model: Routine)
    func dismissPomodoroAndSoundScreen()
}

class RoutinesCoordinator: NavigationCoordinator {
    var isCompleted: (() -> Void)?
    var rootViewController: UINavigationController
    var childCoordinators = [Coordinator]()

    init() {
        self.rootViewController = UINavigationController()
    }

    func start(viewController: UIViewController) {
        self.rootViewController.viewControllers = [viewController]
    }

    func start() {}

    func presentRoutineDetails(model: Routine) {
        let viewController = RoutineDetailsFactory.make(model: model, delegate: self)
        self.rootViewController.pushViewController(viewController, animated: true)
    }
}

extension RoutinesCoordinator: RoutinesCoordinatorDelegate {
    func presentPomodoroAndSoundScreen(model: Routine) {
        let viewController = PomodoroAndSoundFactory.make(model: model, delegate: self)
        self.rootViewController.pushViewController(viewController, animated: true)
    }

    func dismissPomodoroAndSoundScreen() {
        self.rootViewController.popViewController(animated: true)
    }
}
