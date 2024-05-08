//
//  SelectPomodoroFactory.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 07/05/24.
//

import UIKit

enum SelectPomodoroFactory {
    static func make(delegate: RoutinesCoordinatorDelegate) -> UIViewController {
        let viewController = SelectPomodoroViewController()
        let presenter = SelectPomodoroPresenter()
        let interactor = SelectPomodoroInteractor(presenter: presenter)

        presenter.viewController = viewController
        presenter.delegate = delegate
        viewController.interactor = interactor

        return viewController
    }
}
