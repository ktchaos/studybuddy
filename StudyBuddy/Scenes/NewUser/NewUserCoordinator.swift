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

    func presentOnboardingScreen(with name: String, delegate: AppCoordinatorDelegate) {
        let viewController = OnboardingRankingViewController()
        viewController.delegate = delegate
        viewController.titleLabel.text = "Olá, \(name)"

        if let view = self.rootViewController.topViewController?.view {
            UIView.transition(with: view, duration: 2, options: .transitionCrossDissolve) {
                viewController.view.alpha = 1.0
                self.rootViewController.pushViewController(viewController, animated: true)
            }
        }
    }
}
