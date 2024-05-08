//
//  SelectPomodoroInteractor.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 07/05/24.
//

protocol SelectPomodoroInteracting {
    func didTapMinusButton()
    func didTapPlusButton()
    func didTapContinue()
}

final class SelectPomodoroInteractor: SelectPomodoroInteracting {
    private let presenter: SelectPomodoroPresenting

    private var currentNumberOfSessions: Int = 1

    init(presenter: SelectPomodoroPresenting) {
        self.presenter = presenter
    }
}

extension SelectPomodoroInteractor {
    func didTapMinusButton() {
        currentNumberOfSessions -= 1
        presenter.updateSessionsNumber(with: currentNumberOfSessions)

        if currentNumberOfSessions == 12 {
            presenter.disablePlusButton()
        } else if currentNumberOfSessions == 1 {
            presenter.disableMinusButton()
        } else {
            presenter.enablePlusButton()
            presenter.enableMinusButton()
        }
    }

    func didTapPlusButton() {
        currentNumberOfSessions += 1
        presenter.updateSessionsNumber(with: currentNumberOfSessions)

        if currentNumberOfSessions == 12 {
            presenter.disablePlusButton()
        } else if currentNumberOfSessions == 1 {
            presenter.disableMinusButton()
        } else {
            presenter.enablePlusButton()
            presenter.enableMinusButton()
        }
    }

    func didTapContinue() {
        presenter.didTapContinue(with: currentNumberOfSessions)
    }
}
