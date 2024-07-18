//
//  EditRoutineViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 24/04/24.
//

import UIKit
import SnapKit

protocol EditRoutineViewControlling {

}

class EditRoutineViewController: UIViewController, EditRoutineViewControlling {
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.textColor = .black
        return textField
    }()
    private lazy var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        return textField
    }()
    private lazy var pomodoroLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Editar Pomodoro"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private lazy var pomodoroStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [pomodoroLabel])
        stack.axis = .horizontal
        stack.layer.borderWidth = 0.1
        stack.layer.cornerRadius = 8
        stack.backgroundColor = .systemGray4
        stack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.didTapEditPomodoro)))
        return stack
    }()
    private lazy var soundLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = " Editar som em background"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private lazy var soundStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [soundLabel])
        stack.axis = .horizontal
        stack.layer.borderWidth = 0.1
        stack.layer.cornerRadius = 8
        stack.backgroundColor = .systemGray4
        stack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.didTapEditSound)))
        return stack
    }()
    private lazy var blockedAppsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Editar aplicativos", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .systemGray6
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textColor = .black
        button.addTarget(self, action: #selector(self.didTapEditAppsButton), for: .touchUpInside)
        return button
    }()
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textColor = .black
        button.setTitle("Deletar rotina", for: .normal)
        button.backgroundColor = .systemRed
        button.alpha = 0.7
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.addTarget(self, action: #selector(self.didTapDeleteButton), for: .touchUpInside)
        return button
    }()
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textColor = .black
        button.setTitle("Salvar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(self.didTapSaveButton), for: .touchUpInside)
        return button
    }()

    var interactor: EditRoutineInteracting?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backItem?.backButtonTitle = " "
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.navigationBar.backItem?.backButtonTitle = " "
        }

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.navigationBar.backItem?.backButtonTitle = " "
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViews()
        navigationController?.navigationBar.backItem?.backButtonTitle = " "
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
    }

    func setupUI() {
        title = interactor?.getRoutineTitle()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backItem?.backButtonTitle = " "
        view.backgroundColor = .white
        titleTextField.text = "Novo título..."
        descriptionTextField.text = "Nova descrição..."
    }

    func setupViews() {
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(pomodoroStack)
        view.addSubview(soundStack)
        view.addSubview(blockedAppsButton)
        view.addSubview(deleteButton)

        titleTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(160)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.width.equalTo(54)
        }

        descriptionTextField.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.width.equalTo(34)
        }

        pomodoroStack.snp.makeConstraints {
            $0.top.equalTo(descriptionTextField.snp.bottom).offset(24)
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

        blockedAppsButton.snp.makeConstraints {
            $0.top.equalTo(soundStack.snp.bottom).offset(52)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }

        deleteButton.snp.makeConstraints {
            $0.top.equalTo(blockedAppsButton.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
    }

    func addShadow(view: UIView, shadowColor: CGColor = UIColor.black.cgColor, shadowOffset: CGSize = .zero, shadowOpacity: Float = 0.5, shadowRadius: CGFloat = 5.0) {
        view.layer.shadowColor = shadowColor
        view.layer.shadowOffset = shadowOffset
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowRadius = shadowRadius
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 12
    }
}

extension EditRoutineViewController {
    @objc func didTapSaveButton() {
//        guard let title = self.titleTextField.text, let description = self.descriptionTextField.text else {
//            return
//        }
//        interactor?.onSaveButtonTap(title: title, description: description)
        self.dismiss(animated: true)
    }

    @objc func didTapDeleteButton() {
        interactor?.onDeleteButtonTap()
    }

    @objc func didTapEditSound() {
        let viewController = SelectBackgroundSoundFactory.make(delegate: self)//SelectBackgroundSoundViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
//        interactor?.onEditButtonTap()
    }

    @objc func didTapEditPomodoro() {
        let viewController = SelectPomodoroViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
//        interactor?.onEditPomodoroTap()
    }

    @objc func didTapEditAppsButton() {
        let viewController = SelectAppsToBlockViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
//        interactor?.onEditAppsButtonTap()
    }
}

extension EditRoutineViewController: RoutinesCoordinatorDelegate {
    func presentPomodoroAndSoundScreen(model: Routine) {

    }
    
    func dismissPomodoroAndSoundScreen() {

    }
    
    func presentNewRoutineScreen() {

    }
    
    func presentPomodoroSessionsScreen(title: String, description: String) {

    }
    
    func presentSelectAudioScreen(with numberOfSessions: Int) {

    }
    
    func presentSelectAppsToBlockScreen(with audioPath: String, type: String) {

    }
    
    func finishRoutineCreation() {

    }
    
    func presentEditRoutineScreen(routine: Routine) {

    }
    
    func onRoutineDeletion() {

    }
    

}
