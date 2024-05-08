//
//  RoutineDetailsPresenter.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 06/05/24.
//

protocol RoutineDetailsPresenting {
    var viewController: RoutineDetailsViewControlling? { get set }

    func goToPomodoroAndSoundScreen(model: Routine)
    func goToEditRoutineScreen(routine: Routine)
}

final class RoutineDetailsPresenter: RoutineDetailsPresenting {
    private let coordinator: RoutinesDetailsCoordinator
    var viewController: RoutineDetailsViewControlling?

    init(coordinator: RoutinesDetailsCoordinator) {
        self.coordinator = coordinator
    }
}

extension RoutineDetailsPresenter {
    func goToPomodoroAndSoundScreen(model: Routine) {
        coordinator.presentPomodoroAndSoundScreen(model: model)
    }

    func goToEditRoutineScreen(routine: Routine) {
        coordinator.presentEditRoutineScreen(routine: routine)
    }
}
