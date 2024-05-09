//
//  PomodoroAndSoundPresenter.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 06/05/24.
//

protocol PomodoroAndSoundPresenting {
    var viewController: PomodoroAndSoundViewControlling? { get set }

    func updateSessionLabel(hours: String, minutes: String, seconds: String)
    func updateBreakLabel(hours: String, minutes: String, seconds: String)
    func enableSessionLabel()
    func enableBreakLabel()
    func dismissScreen()
}

final class PomodoroAndSoundPresenter: PomodoroAndSoundPresenting {
    private let coordinator: PomodoroAndSoundCoordinator
    var viewController: PomodoroAndSoundViewControlling?

    init(coordinator: PomodoroAndSoundCoordinator) {
        self.coordinator = coordinator
    }
}

extension PomodoroAndSoundPresenter {
    func updateSessionLabel(hours: String, minutes: String, seconds: String) {
        let time = "\(hours):\(minutes):\(seconds)"
        viewController?.updatePomodoroLabel(with: time)
    }

    func updateBreakLabel(hours: String, minutes: String, seconds: String) {
        let time = "\(minutes):\(seconds)"
        viewController?.updateBreakLabel(with: time)
    }

    func enableSessionLabel() {
        viewController?.enablePomodoroLabel()
    }

    func enableBreakLabel() {
        viewController?.enableBreakLabel()
    }

    func dismissScreen() {
        coordinator.dismissScreen()
    }
}
