//
//  RankingInteractor.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/05/24.
//

import FirebaseFirestore
import Foundation

protocol RankingInteracting {
    func loadRanking(completion: @escaping () -> Void)
    func getDataSourceCount() -> Int
    func getUser(at row: Int) -> User
}

final class RankingInteractor: RankingInteracting {
    private let presenter: RankingPresenting
    private var users: [User] = []

    init(presenter: RankingPresenting) {
        self.presenter = presenter
    }

    func loadRanking(completion: @escaping () -> Void) {
        Firestore.firestore().collection("users").getDocuments { [weak self] (snapshot, error) in
            snapshot?.documents.forEach({ queryDocument in
                let data = queryDocument.data()
                let username = data["username"] as? String
                let points = data["points"] as? Double

                let user = User(username: username ?? "", points: points ?? 0.0)
                self?.users.append(user)
            })

            self?.users.sort { $0.points > $1.points }
            completion()
        }
    }

    func getDataSourceCount() -> Int {
        return self.users.count
    }

    func getUser(at row: Int) -> User {
        return self.users[row]
    }
}
