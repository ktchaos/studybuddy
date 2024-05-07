//
//  PomodoroAndSoundInteractor.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 06/05/24.
//

import Foundation
import AVFAudio

protocol PomodoroAndSoundInteracting {
    func didTapStartPomodoro()
    func didTapResetPomodoro()
    func didTapFinishRoutine()
    func startPlayingAudio()
    func stopPlayingAudio()
}

final class PomodoroAndSoundInteractor: PomodoroAndSoundInteracting {
    private let presenter: PomodoroAndSoundPresenting
    private let routine: Routine

    private var pomodoroTimer: Timer = Timer()
    private var breakTimer: Timer = Timer()

    private var currentPomodoroTime = 3000
    private var currentBreakTime = 600
    private var sessionsDone = 0

    private var player: AVAudioPlayer?

    init(presenter: PomodoroAndSoundPresenting, routine: Routine) {
        self.presenter = presenter
        self.routine = routine
    }
}

// MARK: Pomodoro functions
extension PomodoroAndSoundInteractor {
    func didTapStartPomodoro() {
        startPomodoro()
    }

    func startPomodoro() {
        if sessionsDone == self.routine.numberOfSessions {

            print("ACABOU NE")
        } else {
            self.pomodoroTimer = Timer.scheduledTimer(
                timeInterval: 1,
                target: self,
                selector: #selector(self.pomodoroTimerUpdated),
                userInfo: nil,
                repeats: true
            )
        }
    }

    func didTapResetPomodoro() {
        pomodoroTimer.invalidate()
        breakTimer.invalidate()
    }

    func didTapFinishRoutine() {
        presenter.dismissScreen()
    }

    @objc private func pomodoroTimerUpdated() {
        currentPomodoroTime -= 1

        // END OF SESSION
        if currentPomodoroTime == 0 {
            // Stop pomodoro timer and
            // Start break timer
            self.presenter.updateSessionLabel(hours: "00", minutes: "00", seconds: "00")
            self.pomodoroTimer.invalidate()
            self.presenter.enableBreakLabel()
            self.breakTimer = Timer.scheduledTimer(
                timeInterval: 1,
                target: self,
                selector: #selector(self.breakTimerUpdated),
                userInfo: nil,
                repeats: true
            )
        } else {
            let (hours, minutes, seconds) = secondsToHoursMinutesSeconds(currentPomodoroTime)
            presenter.updateSessionLabel(hours: "\(hours)", minutes: "\(minutes)", seconds: "\(seconds)")
        }
    }

    @objc private func breakTimerUpdated() {
        currentBreakTime -= 1

        if currentBreakTime == 0 {
            // Stop break timer and restart session timer
            self.presenter.updateBreakLabel(hours: "00", minutes: "00", seconds: "00")
            self.breakTimer.invalidate()
            self.currentPomodoroTime = 3000
            self.currentBreakTime = 600
            self.presenter.enableSessionLabel()
            self.sessionsDone += 1
            self.startPomodoro()
            return
        }
        let (hours, minutes, seconds) = secondsToHoursMinutesSeconds(currentBreakTime)
        presenter.updateBreakLabel(hours: "\(hours)", minutes: "\(minutes)", seconds: "\(seconds)")
    }
}

// MARK: Audio functions
extension PomodoroAndSoundInteractor {
    func startPlayingAudio() {
        let audioPath = self.routine.audio.path
        let audioUrl = Bundle.main.path(forResource: audioPath, ofType: "mp3")

        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)

            guard let url = audioUrl else {
                return
            }

            self.player = try AVAudioPlayer(contentsOf: URL(string: url) ?? URL(fileURLWithPath: url))
            guard let player = self.player else {
                return
            }

            player.play()

        } catch {
            print("ERror alksdjlakdjslkasd")
        }
    }

    func stopPlayingAudio() {
        player?.stop()
    }
}

// MARK: Helpers
extension PomodoroAndSoundInteractor {
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
