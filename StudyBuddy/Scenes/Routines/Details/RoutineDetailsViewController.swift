//
//  RoutineDetailsViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/06/23.
//

import UIKit
import SnapKit

protocol RoutineDetailsViewControlling {

}

final class RoutineDetailsViewController: BaseViewController, RoutineDetailsViewControlling {
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textColor = .black
        button.setTitle("Editar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(self.didTapEditButton), for: .touchUpInside)
        return button
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Start routine ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(self.didTapStartButton), for: .touchUpInside)
        return button
    }()
    private lazy var pomodoroLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "  Pomodoro"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private lazy var pomodoroToggle: UILabel = {
        let toggle = UILabel()
        toggle.font = UIFont.systemFont(ofSize: 14)
        return toggle
    }()
    private lazy var pomodoroStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [pomodoroLabel, pomodoroToggle])
        stack.axis = .horizontal
        stack.layer.borderWidth = 0.1
        stack.layer.cornerRadius = 8
        stack.backgroundColor = .systemGray6
        stack.distribution = .fillEqually
        return stack
    }()
    private lazy var soundLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "  Sound "
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private lazy var soundToggle: UILabel = {
        let toggle = UILabel()
        toggle.font = UIFont.systemFont(ofSize: 14)
        return toggle
    }()
    private lazy var soundStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [soundLabel, soundToggle])
        stack.axis = .horizontal
        stack.layer.borderWidth = 0.1
        stack.layer.cornerRadius = 8
        stack.backgroundColor = .systemGray6
        stack.distribution = .fillEqually
        return stack
    }()

    var interactor: RoutineDetailsInteractor?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViews()
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editButton)
    }

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        title = "Rotina editada"
//        descriptionLabel.text = "descrição editada"
//        navigationController?.navigationBar.backItem?.backButtonTitle = " "
//    }

    func setupUI() {
        title = interactor?.getTitle()
        pomodoroToggle.text = interactor?.getNumberOfSessions()
        soundToggle.text = interactor?.getSoundType()
        descriptionLabel.text = interactor?.getDescription()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
    }

    func setupViews() {
        view.addSubview(editButton)
        view.addSubview(descriptionLabel)
        view.addSubview(pomodoroStack)
        view.addSubview(soundStack)
        view.addSubview(startButton)

        view.bringSubviewToFront(editButton)

        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }

        startButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(36)
            $0.leading.equalToSuperview().offset(42)
            $0.trailing.equalToSuperview().inset(42)
            $0.height.equalTo(42)
        }

        pomodoroStack.snp.makeConstraints {
            $0.top.equalTo(startButton.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(42)
        }

        soundStack.snp.makeConstraints {
            $0.top.equalTo(pomodoroStack.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(42)
        }
    }
}

extension RoutineDetailsViewController {
    @objc func didTapEditButton() {
        interactor?.didTapEditButton()
    }

    @objc func didTapStartButton() {
        interactor?.onStartButtonTap()
    }
}
