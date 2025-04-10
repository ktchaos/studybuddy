//
//  NewUserInteractor.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 05/05/24.
//

import FirebaseCore
import FirebaseFirestore

protocol NewUserInteracting {
    func createUser(with username: String?)
}

class NewUserInteractor: NewUserInteracting {
    let presenter: NewUserPresenting

    private let database = Firestore.firestore()
    private let userDefaults = UserDefaults.standard
    private let isLoggedKey: String = "isLogged"
    private let username: String = "username"

    init(presenter: NewUserPresenting) {
        self.presenter = presenter
    }
}

extension NewUserInteractor {
    func createUser(with username: String?) {
        guard let name = username else {
            presenter.displayError(with: "Error creating user")
            return
        }

        if name.isEmpty {
            presenter.displayError(with: "The username cannot be empty")
        } else if name.count < 6 {
            presenter.displayError(with: "The username must be at least 6 characters long")
        } else {
            createUser(with: name)
        }
    }

    private func createUser(with username: String) {
        // MARK: Save on UserDefaults and to the Firestore database
        userDefaults.set(true, forKey: isLoggedKey)
        userDefaults.set(username, forKey: self.username)
        database.collection("users").addDocument(data: ["username": username]) { [weak self] error in
            if error != nil {
                self?.presenter.displayError(with: "An unexpected error occurred, please try again")
            } else {
                self?.presenter.goToOnboardingScreen(with: username)
            }
        }
    }
}
