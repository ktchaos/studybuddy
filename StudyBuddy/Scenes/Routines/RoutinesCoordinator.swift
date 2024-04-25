//
//  RoutinesCoordinator.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 23/04/24.
//

import Foundation
import UIKit

class RoutinesCoordinator: NavigationCoordinator {
    var isCompleted: (() -> Void)?
    var rootViewController: UINavigationController
    var childCoordinators = [Coordinator]()

    init() {
        self.rootViewController = UINavigationController()
    }

    func start() {
        let searchViewController = MainViewController()
//        let searchViewModel = DefaultSearchViewModel(coordinator: self)
//        searchViewController.bind(to: searchViewModel)
        self.rootViewController.viewControllers = [searchViewController]
    }
}
