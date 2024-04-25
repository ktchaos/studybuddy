//
//  NewUserViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 24/04/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NewUserViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Bem vindo ao Study Buddy"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AppIcon")
        return imageView
    }()

    private lazy var usernameTextField: UITextField = {
        let label = UITextField()
        label.placeholder = "Insira um nome de usuário"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.layer.cornerRadius = 7
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.systemGray6.cgColor

        return label
    }()

    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Entrar", for: .normal)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.systemGray6
        button.layer.cornerRadius = 7
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(self.onStartButtonTap), for: .touchUpInside)
        return button
    }()

    let userDefaults = UserDefaults.standard
    let isLoggedKey: String = "isLogged"

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(iconImageView)
        view.addSubview(usernameTextField)
        view.addSubview(startButton)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }

        iconImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(42)
            $0.height.width.equalTo(200)
            $0.centerX.equalToSuperview()
        }

        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(42)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(42)
        }

        startButton.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(64)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(42)
        }
    }

    @objc func onStartButtonTap() {
        if usernameTextField.text?.isEmpty ?? false {
            usernameTextField.layer.borderColor = UIColor.red.cgColor
            let alert = UIAlertController(title: "Insira um nome válido!", message: "O nome não pode ser vazio", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(action)
            present(alert, animated: true)
        } else {
            userDefaults.set(true, forKey: isLoggedKey)
            let coordinator = MainCoordinator(tabBarScenes: StudyBuddyTabBarScene.allCases)
            coordinator.start()
            self.navigationController?.modalPresentationStyle = .fullScreen
            self.navigationController?.present(coordinator.rootViewController, animated: true)
//            self.navigationController.
        }
    }
}
