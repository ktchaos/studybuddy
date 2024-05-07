//
//  MainCoordinator.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 23/04/24.
//

import Foundation
import UIKit

class MainCoordinator: TabBarCoordinator {
    private var tabBarScenes: [TabBarScene]

    var isCompleted: (() -> Void)?
    var rootViewController: UITabBarController
    var childCoordinators = [Coordinator]()

    init(tabBarScenes: [TabBarScene]) {
        self.rootViewController = UITabBarController()
        self.tabBarScenes = tabBarScenes
    }

    private func setupTabBar() {
        let tabBar = self.rootViewController.tabBar
        tabBar.tintColor = .black
        tabBar.barTintColor = .black
        tabBar.unselectedItemTintColor = .gray
    }

    private func setupTabBarScenes() {
        self.rootViewController.viewControllers = self.tabBarScenes.map {
            let coordinator = $0.coordinator
            self.start(coordinator: coordinator)
            let rootViewController = coordinator.rootViewController
            rootViewController.tabBarItem.title = $0.title
            rootViewController.tabBarItem.image = UIImage(systemName: $0.iconNameOff)?.withRenderingMode(.alwaysOriginal)
            rootViewController.tabBarItem.selectedImage = UIImage(
                named: $0.iconNameOn
            )?.withRenderingMode(.alwaysOriginal)

            return rootViewController
        }
    }

    func start() {
        self.setupTabBar()
        self.setupTabBarScenes()
        self.rootViewController.modalPresentationStyle = .fullScreen
    }
}
