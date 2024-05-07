//
//  ProfileCoordinator.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 23/04/24.
//

import Foundation
import UIKit

class ProfileCoordinator: NavigationCoordinator {
    var isCompleted: (() -> Void)?
    var rootViewController: UINavigationController
    var childCoordinators = [Coordinator]()

    init() {
        self.rootViewController = UINavigationController()
    }

    func start(viewController: UIViewController) {
        self.rootViewController.viewControllers = [viewController]
    }

    func start() {
//        let profileViewController = ProfileViewController()
//        self.rootViewController.viewControllers = [profileViewController]
    }

    func presentRankingScreen() {
        let viewController = RankingViewController()
        self.rootViewController.pushViewController(viewController, animated: true)
    }

    func presentHelpScreen() {
        let viewController = HelpViewController()
        self.rootViewController.pushViewController(viewController, animated: true)
    }
}
