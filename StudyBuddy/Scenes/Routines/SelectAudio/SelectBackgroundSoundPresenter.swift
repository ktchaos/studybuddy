//
//  SelectBackgroundSoundPresenter.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 07/05/24.
//

protocol SelectBackgroundSoundPresenting {
    var viewController: SelectBackgroundSoundViewControlling? { get set }
    var delegate: RoutinesCoordinatorDelegate? { get set }

    func onTapNotUsingButton()
    func goToBlockedAppsSelection(with audioPath: String, type: String)
}

final class SelectBackgroundSoundPresenter: SelectBackgroundSoundPresenting {
    var viewController: SelectBackgroundSoundViewControlling?
    var delegate: RoutinesCoordinatorDelegate?

    func onTapNotUsingButton() {
        delegate?.presentSelectAppsToBlockScreen(with: "", type: "")
    }

    func goToBlockedAppsSelection(with audioPath: String, type: String) {
        delegate?.presentSelectAppsToBlockScreen(with: audioPath, type: type)
    }
}
