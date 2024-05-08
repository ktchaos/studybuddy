//
//  EditRoutineFactory.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/05/24.
//

import UIKit

enum EditRoutineFactory {
    static func make(delegate: RoutinesCoordinatorDelegate, routine: Routine) -> UIViewController {
        let viewController = EditRoutineViewController()
        let presenter = EditRoutinePresenter()
        let interactor = EditRoutineInteractor(presenter: presenter, routine: routine)

        viewController.interactor = interactor
        presenter.delegate = delegate
        presenter.viewController = viewController

        return viewController
    }
}
