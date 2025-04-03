//
//  AppCoordinator.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 22/04/24.
//

import Foundation
import UIKit

enum StudyBuddyTabBarScene: Int, CaseIterable, TabBarScene {
    case routines
    case profile

    var iconNameOn: String {
        switch self {
        case .routines:
            return "clock.circle.fill"
        case .profile:
            return "person.fill"
        }
    }

    var iconNameOff: String {
        switch self {
        case .routines:
            return "clock.circle"
        case .profile:
            return "person"
        }
    }

    var title: String {
        switch self {
        case .routines:
            return "Rotinas"
        case .profile:
            return "Perfil"
        }
    }

    var coordinator: NavigationCoordinator {
        switch self {
        case .routines:
            return MainFactory.make()
        case .profile:
            return ProfileFactory.make()
        }
    }
}

protocol AppCoordinatorDelegate {
    func showMainRoute(window: UIWindow?)
}

class AppCoordinator: Coordinator, AppCoordinatorDelegate {
    var isCompleted: (() -> Void)?
    var childCoordinators = [Coordinator]()

    let window: UIWindow
    let userDefaults = UserDefaults.standard
    let isLoggedKey: String = "isLogged"

    init(windowScene: UIWindowScene) {
        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        self.window.windowScene = windowScene
    }

    func start() {
        if userDefaults.bool(forKey: isLoggedKey) {
            self.showMainRoute(window: self.window)
        } else {
            showNewUserRoute()
        }
    }

    func showMainRoute(window: UIWindow?) {
        let coordinator = MainCoordinator(tabBarScenes: StudyBuddyTabBarScene.allCases, window: window)
        self.start(coordinator: coordinator)
        self.window.rootViewController = coordinator.rootViewController
        self.window.makeKeyAndVisible()
    }

    func showNewUserRoute() {
        let (_, coordinator) = NewUserFactory.make(delegate: self)
        self.window.rootViewController = coordinator.rootViewController
        self.window.makeKeyAndVisible()
    }
}
