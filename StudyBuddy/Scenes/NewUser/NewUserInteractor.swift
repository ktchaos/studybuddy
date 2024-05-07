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

    init(presenter: NewUserPresenting) {
        self.presenter = presenter
    }
}

extension NewUserInteractor {
    func createUser(with username: String?) {
        guard let name = username else {
            presenter.displayError(with: "Erro ao criar usuário")
            return
        }

        if name.isEmpty {
            presenter.displayError(with: "O nome de usuário não pode ser vazio")
        } else if name.count < 6 {
            presenter.displayError(with: "O nome de usuário precisa ter pelo menos 6 caracteres")
        } else {
            createUser(with: name)
        }
    }

    private func createUser(with username: String) {
        // MARK: Save on UserDefaults and to the Firestore database
        userDefaults.set(true, forKey: isLoggedKey)
        database.collection("users").addDocument(data: ["username": username]) { [weak self] error in
            if error != nil {
                print("#DEBUG: 1 ", error)
                self?.presenter.displayError(with: "Um erro inesperado ocorreu, tente novamente")
            } else {
                print("#DEBUG: 2 ", username)
                self?.presenter.goToOnboardingScreen(with: username)
            }
        }
    }
}
