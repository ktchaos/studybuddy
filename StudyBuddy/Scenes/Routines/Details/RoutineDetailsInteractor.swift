//
//  RoutineDetailsInteractor.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 06/05/24.
//

protocol RoutineDetailsInteracting {
    func getTitle() -> String
    func getDescription() -> String
    func onStartButtonTap()
    func didTapEditButton()
    func getNumberOfSessions() -> String
    func getSoundType() -> String
}

final class RoutineDetailsInteractor: RoutineDetailsInteracting {
    private let presenter: RoutineDetailsPresenting
    private let model: Routine

    init(presenter: RoutineDetailsPresenting, model: Routine) {
        self.presenter = presenter
        self.model = model
    }
}

extension RoutineDetailsInteractor {
    func getTitle() -> String {
        return model.title
    }

    func getDescription() -> String {
        return model.description
    }

    func onStartButtonTap() {
        presenter.goToPomodoroAndSoundScreen(model: model)
    }

    func didTapEditButton() {
        presenter.goToEditRoutineScreen(routine: model)
    }

    func getNumberOfSessions() -> String {
        return model.rangeTime
    }

    func getSoundType() -> String {
        return model.audio.type
    }
}
