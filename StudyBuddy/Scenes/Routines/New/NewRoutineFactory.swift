//
//  NewRoutineFactory.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 07/05/24.
//

import UIKit

enum NewRoutineFactory {
    static func make(delegate: RoutinesCoordinatorDelegate) -> UIViewController {
        let viewController = NewRoutineViewController()
        let presenter = NewRoutinePresenter()
        let interactor = NewRoutineInteractor(presenter: presenter)

        viewController.interactor = interactor
        presenter.viewController = viewController
        presenter.delegate = delegate

        return viewController
    }
}
