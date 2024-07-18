//
//  EditRoutineInteractor.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/05/24.
//

import Foundation

protocol EditRoutineInteracting {
    func getRoutineTitle() -> String
    func onDeleteButtonTap()
    func onEditButtonTap()
    func onEditPomodoroTap()
    func onEditAppsButtonTap()
    func onSaveButtonTap(title: String, description: String)
}

final class EditRoutineInteractor: EditRoutineInteracting {
    private let presenter: EditRoutinePresenting
    private let routine: Routine

    var currentRoutines: [Routine] = []
    let userDefaults = UserDefaults.standard
    let userRoutines: String = "userRoutines"

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
        deleteCurrentRoutine()
    }

    func onEditButtonTap() {
        
    }

    func onEditPomodoroTap() {

    }

    func onEditAppsButtonTap() {

    }

    func onSaveButtonTap(title: String, description: String) {
        saveRoutine(title: title, description: description)
    }
}

private extension EditRoutineInteractor {
    func saveRoutine(title: String, description: String) {
//        fetchRoutines()
//
//        do {
//            var newRoutines: [Routine] = []
//            self.currentRoutines.forEach {
//                if $0 == self.routine {
//                    let editedRoutine = Routine(
//                        title: title,
//                        description: description,
//                        rangeTime: $0.rangeTime,
//                        numberOfSessions: $0.numberOfSessions,
//                        audio: $0.audio,
//                        blockedApps: $0.blockedApps
//                    )
//                    newRoutines
//                }
//            }
//
//
//            let encoder = JSONEncoder()
//            let data = try encoder.encode(newRoutines)
//            UserDefaults.standard.set(data, forKey: userRoutines)
//            presenter.redirectToRoutines()
//        } catch {
//            // Catch error
//        }
    }

    func deleteCurrentRoutine() {
        fetchRoutines()

        do {
            var newRoutines: [Routine] = []
            self.currentRoutines.forEach {
                if $0 != self.routine {
                    newRoutines.append($0)
                }
            }

            let encoder = JSONEncoder()
            let data = try encoder.encode(newRoutines)
            UserDefaults.standard.set(data, forKey: userRoutines)
            presenter.redirectToRoutines()
        } catch {
            // Catch error
        }
    }

    func fetchRoutines() {
        guard let data = UserDefaults.standard.data(forKey: userRoutines) else {
            return
        }
        do {
            let decoder = JSONDecoder()
            let currentRoutines = try decoder.decode([Routine].self, from: data)
            self.currentRoutines = currentRoutines
        } catch {
            // Catch error
        }
    }
}
