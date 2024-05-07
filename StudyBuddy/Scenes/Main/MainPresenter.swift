//
//  MainPresenter.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 05/05/24.
//

protocol MainPreseting {
    var viewController: MainViewControlling? { get set }

    func openRoutineDetails(with model: Routine)
}

final class MainPresenter: MainPreseting {
    let coordinator: RoutinesCoordinator
    var viewController: MainViewControlling?

    init(coordinator: RoutinesCoordinator) {
        self.coordinator = coordinator
    }
}

extension MainPresenter {
    func openRoutineDetails(with model: Routine) {
        coordinator.presentRoutineDetails(model: model)
    }
}
