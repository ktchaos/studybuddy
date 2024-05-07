//
//  MainInteractor.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 05/05/24.
//

protocol MainInteracting {
    func getDataSourceCount() -> Int
    func getTitleAndDuration(for row: Int) -> (title: String, duration: String)
    func didSelectCell(at row: Int)
}

final class MainInteractor: MainInteracting {
    private let presenter: MainPreseting
    private let dataSource: [Routine]

    init(presenter: MainPreseting) {
        self.presenter = presenter
        self.dataSource = [Routine(title: "Teste title", description: "name of routine", rangeTime: "lalala", numberOfSessions: 3, audio: .init(path: "frequency"))]
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
}
