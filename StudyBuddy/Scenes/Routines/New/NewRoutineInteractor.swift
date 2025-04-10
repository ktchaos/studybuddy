//
//  NewRoutineInteractor.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 07/05/24.
//

protocol NewRoutineInteracting {
    func didTapContinueButton(title: String?, description: String?)
}

final class NewRoutineInteractor: NewRoutineInteracting {
    private let presenter: NewRoutinePresenting

    init(presenter: NewRoutinePresenting) {
        self.presenter = presenter
    }
}

extension NewRoutineInteractor {
    func didTapContinueButton(title: String?, description: String?) {
        guard let title = title, let description = description else {
            return
        }

        if title.isEmpty {
            presenter.displayErrorOnTitle(with: "The title can't be empty")
            return
        }
        if description.isEmpty {
            presenter.displayErrorOnDescription(with: "The description can't be empty")
            return
        }

        presenter.openSelectPomodoroSessions(title: title, description: description)
    }
}
