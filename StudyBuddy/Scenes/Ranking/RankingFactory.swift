//
//  RankingFactory.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/05/24.
//

import UIKit

enum RankingFactory {
    static func make() -> UIViewController {
        let viewController = RankingViewController()
        let presenter = RankingPresenter()
        let interactor = RankingInteractor(presenter: presenter)

        presenter.viewController = viewController
        viewController.interactor = interactor

        return viewController
    }
}
