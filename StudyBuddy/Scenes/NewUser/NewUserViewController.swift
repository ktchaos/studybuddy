//
//  NewUserViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 24/04/24.
//

import UIKit
import SnapKit

struct UserDefaultKeys {
    let isLoggedKey: String
    let usernameKey: String
}

protocol NewUserViewControlling {
    func displayError(with message: String)
}

class NewUserViewController: UIViewController, NewUserViewControlling {
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
        label.placeholder = "insira um nome de usuário"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.layer.cornerRadius = 7
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.systemGray2.cgColor
        label.autocapitalizationType = .none
        return label
    }()

    private lazy var tipsUsernameLabel: UILabel = {
        let label = UILabel()
        label.text = "seu nome pode conter números e símbolos"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
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

    private lazy var copyrightLabel: UILabel = {
        let label = UILabel()
        label.text = "Desenvolvido por Catarina Serrano ©"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .systemGray2
        return label
    }()
    
    var interactor: NewUserInteracting?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func setupViews() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(iconImageView)
        view.addSubview(usernameTextField)
        view.addSubview(startButton)
        view.addSubview(copyrightLabel)
        view.addSubview(tipsUsernameLabel)

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
            $0.top.equalTo(usernameTextField.snp.bottom).offset(82)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(42)
        }

        tipsUsernameLabel.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
        }

        copyrightLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
    }

    func displayError(with message: String) {
        usernameTextField.layer.borderColor = UIColor.red.cgColor
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }

    @objc func onStartButtonTap() {
        interactor?.createUser(with: usernameTextField.text)
    }
}
