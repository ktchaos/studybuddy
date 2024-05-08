//
//  MainInteractor.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 05/05/24.
//

import Foundation

protocol MainInteracting {
    func getDataSourceCount() -> Int
    func getTitleAndDuration(for row: Int) -> (title: String, duration: String)
    func didSelectCell(at row: Int)
    func didTapCreateRoutine()
    func viewDidAppear()
}

final class MainInteractor: MainInteracting {
    private let presenter: MainPreseting
    private var dataSource: [Routine] = []

    let userDefaults = UserDefaults.standard
    let userRoutines: String = "userRoutines"

    init(presenter: MainPreseting) {
        self.presenter = presenter
        fetchRoutines()
    }

    private func fetchRoutines() {
        guard let data = UserDefaults.standard.data(forKey: userRoutines) else {
            return
        }
        do {
            let decoder = JSONDecoder()
            let currentRoutines = try decoder.decode([Routine].self, from: data)
            self.dataSource = currentRoutines
        } catch {
            // Fallback
        }
    }
}

extension MainInteractor {
    func getDataSourceCount() -> Int {
        return dataSource.count
    }

    func getTitleAndDuration(for row: Int) -> (title: String, duration: String) {
        let routine = dataSource[row]
        return (routine.title, routine.rangeTime)
    }

    func didSelectCell(at row: Int) {
        let routine = dataSource[row]
        presenter.openRoutineDetails(with: routine)
    }

    func didTapCreateRoutine() {
        presenter.openNewRoutineScreen()
    }

    func viewDidAppear() {
        fetchRoutines()
    }
}
