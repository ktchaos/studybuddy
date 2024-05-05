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

    func start() {
        let newUserViewController = NewUserViewController()
        self.rootViewController.viewControllers = [newUserViewController]
    }

    func showMainRoute() {
        let coordinator = MainCoordinator(tabBarScenes: StudyBuddyTabBarScene.allCases)
        self.rootViewController.present(coordinator.rootViewController, animated: true)
//        self.start(coordinator: coordinator)
//        self.rootViewController = coordinator.rootViewController.
//        self.window.makeKeyAndVisible()
    }
}
