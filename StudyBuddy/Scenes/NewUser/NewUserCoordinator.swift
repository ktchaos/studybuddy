//
//  NewUserCoordinator.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 24/04/24.
//

import Foundation
import UIKit

class NewUserCoordinator: NavigationCoordinator {
    var isCompleted: (() -> Void)?
    var rootViewController: UINavigationController
    var childCoordinators = [Coordinator]()

    init() {
        self.rootViewController = UINavigationController()
    }

    func start() {}

    func start(viewController: NewUserViewController) {
        self.rootViewController.viewControllers = [viewController]
    }

    func showMainRoute() {
        let coordinator = MainCoordinator(tabBarScenes: StudyBuddyTabBarScene.allCases)
        self.rootViewController.present(coordinator.rootViewController, animated: true)
    }

    func presentOnboardingScreen(with name: String) {
        let viewController = OnboardingRankingViewController()
        viewController.titleLabel.text = "Olá, \(name)"
        self.rootViewController.pushViewController(viewController, animated: true)
    }
}
