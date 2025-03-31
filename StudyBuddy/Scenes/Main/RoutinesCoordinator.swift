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
    func presentNewRoutineScreen()
    func presentPomodoroSessionsScreen(title: String, description: String)
    func presentSelectAudioScreen(with numberOfSessions: Int)
    func presentSelectAppsToBlockScreen(with audioPath: String, type: String)
    func finishRoutineCreation()
    func presentEditRoutineScreen(routine: Routine)
    func onRoutineDeletion()
}

class RoutinesCoordinator: NavigationCoordinator {
    var isCompleted: (() -> Void)?
    var rootViewController: UINavigationController
    var childCoordinators = [Coordinator]()

    var routine = Routine()
    var currentRoutines: [Routine] = []
    let userDefaults = UserDefaults.standard
    let userRoutines: String = "userRoutines"

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

    func presentEditRoutineScreen(routine: Routine) {
        let viewController = EditRoutineFactory.make(delegate: self, routine: routine)
        self.rootViewController.pushViewController(viewController, animated: true)
    }

    func dismissPomodoroAndSoundScreen() {
        self.rootViewController.popViewController(animated: true)
    }

    func presentNewRoutineScreen() {
        let viewController = NewRoutineFactory.make(delegate: self)
        self.rootViewController.pushViewController(viewController, animated: true)
    }

    func presentPomodoroSessionsScreen(title: String, description: String) {
        routine.title = title
        routine.description = description

        let viewController = SelectPomodoroFactory.make(delegate: self)
        self.rootViewController.pushViewController(viewController, animated: true)
    }

    func presentSelectAudioScreen(with numberOfSessions: Int) {
        routine.numberOfSessions = numberOfSessions
        routine.rangeTime = "\(numberOfSessions) sessões"
        let viewController = SelectBackgroundSoundFactory.make(delegate: self)
        self.rootViewController.pushViewController(viewController, animated: true)
    }

    func presentSelectAppsToBlockScreen(with audioPath: String, type: String) {
        routine.audio = Audio(path: audioPath, type: type)
        let viewController = SelectAppsToBlockViewController()
//        viewController.delegate = self
        self.rootViewController.pushViewController(viewController, animated: true)
    }

    func onRoutineDeletion() {
        self.rootViewController.popToRootViewController(animated: true)
    }

    func finishRoutineCreation() {
        fetchRoutines()

        do {
            self.currentRoutines.append(self.routine)
            let encoder = JSONEncoder()
            let data = try encoder.encode(self.currentRoutines)
            UserDefaults.standard.set(data, forKey: userRoutines)
            print(#function, "rotinas -> ", self.currentRoutines)
            self.rootViewController.popToRootViewController(animated: true)
        } catch {
            // Catch error
        }
    }

    func fetchRoutines() {
        guard let data = UserDefaults.standard.data(forKey: userRoutines) else {
            return
        } 
        do {
            let decoder = JSONDecoder()
            let currentRoutines = try decoder.decode([Routine].self, from: data)
            self.currentRoutines = currentRoutines
        } catch {
            // Catch error
        }
    }
}
