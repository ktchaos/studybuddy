//
//  PomodoroAndSoundInteractor.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 06/05/24.
//

import FirebaseCore
import FirebaseFirestore
import Foundation
import AVFAudio
import StudyBuddyShieldActionExtension

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
    private let userDefaults = UserDefaults.standard
    private let usernameKey: String = "username"
    private let pointsKey: String = "points"
    private let database = Firestore.firestore()
    private let shieldManager = ShieldManager()

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

    func savePoints(points: Double) {
        Firestore.firestore().collection("users").getDocuments { [weak self] (snapshot, error) in
            snapshot?.documents.forEach({ queryDocument in
                let data = queryDocument.data()
                let username = data["username"] as? String

                if username == UserDefaults.standard.string(forKey: "username") {
                    // Save the points remotly
                    self?.savePointsForUser(id: queryDocument.documentID, points: points)
                }
            })
        }
    }

    func savePointsForUser(id: String, points: Double) {
        Firestore.firestore().collection("users").document(id).updateData(["points": points])
    }
}

// MARK: Pomodoro functions
extension PomodoroAndSoundInteractor {
    func didTapStartPomodoro() {
        startPomodoro()
    }

    func startPomodoro() {
        shieldManager.shieldActivities()
        
        if sessionsDone == self.routine.numberOfSessions {
            presenter.dismissScreen()
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
        player?.stop()
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
            // unblock apps
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
            let currentPoints = userDefaults.double(forKey: pointsKey)
            let newPoints = (Double(self.sessionsDone) * 10.0) + currentPoints
            // Save points local and remote
            self.userDefaults.setValue(newPoints, forKey: pointsKey)
            self.savePoints(points: newPoints)
            
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
            // Fallback for audio
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
