//
//  NewRoutinePresenter.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 07/05/24.
//

protocol NewRoutinePresenting: AnyObject {
    var viewController: NewRoutineViewControlling? { get set }
    var delegate: RoutinesCoordinatorDelegate? { get set }

    func openSelectPomodoroSessions(title: String, description: String)
    func displayErrorOnTitle(with message: String)
    func displayErrorOnDescription(with message: String)
}

final class NewRoutinePresenter: NewRoutinePresenting {
    var viewController: NewRoutineViewControlling?
    var delegate: RoutinesCoordinatorDelegate?

    func openSelectPomodoroSessions(title: String, description: String) {
        delegate?.presentPomodoroSessionsScreen(title: title, description: description)
    }

    func displayErrorOnTitle(with message: String) {
        viewController?.displayErrorOnTitle(message: message)
    }

    func displayErrorOnDescription(with message: String) {
        viewController?.displayErrorOnDescription(message: message)
    }
}
