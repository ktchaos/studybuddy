//
//  EditRoutinePresenter.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/05/24.
//

protocol EditRoutinePresenting {
    var viewController: EditRoutineViewControlling? { get set }
    var delegate: RoutinesCoordinatorDelegate? { get set }
}

final class EditRoutinePresenter: EditRoutinePresenting {
    var viewController: EditRoutineViewControlling?
    var delegate: RoutinesCoordinatorDelegate?

}
