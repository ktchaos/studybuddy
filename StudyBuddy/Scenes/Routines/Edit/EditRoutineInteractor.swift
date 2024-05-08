//
//  EditRoutineInteractor.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/05/24.
//

protocol EditRoutineInteracting {
    func getRoutineTitle() -> String
    func onDeleteButtonTap()
}

final class EditRoutineInteractor: EditRoutineInteracting {
    private let presenter: EditRoutinePresenting
    private let routine: Routine

    init(presenter: EditRoutinePresenting, routine: Routine) {
        self.presenter = presenter
        self.routine = routine
    }
}

extension EditRoutineInteractor {
    func getRoutineTitle() -> String {
        return self.routine.title
    }

    func onDeleteButtonTap() {

    }
}
