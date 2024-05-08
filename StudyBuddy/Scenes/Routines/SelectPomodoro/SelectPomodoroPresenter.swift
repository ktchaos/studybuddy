//
//  SelectPomodoroPresenter.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 07/05/24.
//

protocol SelectPomodoroPresenting {
    var viewController: SelectPomodoroViewControlling? { get set }
    var delegate: RoutinesCoordinatorDelegate? { get set }

    func updateSessionsNumber(with number: Int)
    func disableMinusButton()
    func disablePlusButton()
    func enableMinusButton()
    func enablePlusButton()
    func didTapContinue(with numberOfSessions: Int)
}

final class SelectPomodoroPresenter: SelectPomodoroPresenting {
    var viewController: SelectPomodoroViewControlling?
    var delegate: RoutinesCoordinatorDelegate?

    func updateSessionsNumber(with number: Int) {
        viewController?.updateSessionsLabel(with: "\(number)")
    }

    func disableMinusButton() {
        viewController?.disableMinusButton()
    }

    func disablePlusButton() {
        viewController?.disablePlusButton()
    }

    func enableMinusButton() {
        viewController?.enableMinusButton()
    }

    func enablePlusButton() {
        viewController?.enablePlusButton()
    }

    func didTapContinue(with numberOfSessions: Int) {
        delegate?.presentSelectAudioScreen(with: numberOfSessions)
    }
}
