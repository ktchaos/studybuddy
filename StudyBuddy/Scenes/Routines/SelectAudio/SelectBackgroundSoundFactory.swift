//
//  SelectBackgroundSoundFactory.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 07/05/24.
//

import UIKit

enum SelectBackgroundSoundFactory {
    static func make(delegate: RoutinesCoordinatorDelegate) -> UIViewController {
        let viewController = SelectBackgroundSoundViewController()
        let presenter = SelectBackgroundSoundPresenter()
        let interactor = SelectBackgroundSoundInteractor(presenter: presenter)

        presenter.delegate = delegate
        presenter.viewController = viewController
        viewController.interactor = interactor

        return viewController
    }
}
