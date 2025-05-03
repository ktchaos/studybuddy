//
//  NewRoutineViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/06/23.
//

import UIKit
import SnapKit

protocol NewRoutineViewControlling {
    func displayErrorOnTitle(message: String)
    func displayErrorOnDescription(message: String)
}

final class NewRoutineViewController: BaseViewController, NewRoutineViewControlling {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        return label
    }()
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.delegate = self
        textField.placeholder = "My Routine"
        return textField
    }()
    private lazy var titleErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "Erro ao num sei que num sei que la"
        label.isHidden = true
        label.textColor = .systemRed
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Describe briefly what's the goal of this routine"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        return label
    }()
    private lazy var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.delegate = self
        textField.placeholder = "Focusing to study for my finals..."
        return textField
    }()
    private lazy var descriptionErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "Erro ao num sei que num sei que la"
        label.isHidden = true
        label.textColor = .systemRed
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(self.onNextTap), for: .touchUpInside)
        return button
    }()

    var interactor: NewRoutineInteracting?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViews()
        setupConstraints()
        addPaddingToTextField(titleTextField)
        addPaddingToTextField(descriptionTextField)
    }

    func setupUI() {
        title = "New routine"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
    }

    func setupViews() {
        view.addSubview(titleTextField)
        view.addSubview(titleLabel)
        view.addSubview(titleErrorLabel)
        view.addSubview(descriptionTextField)
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionErrorLabel)
        view.addSubview(nextButton)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
        }

        titleTextField.snp.makeConstraints {
            $0.height.equalTo(64)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(titleLabel.snp.bottom)
        }

        titleErrorLabel.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }

        descriptionLabel.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(titleErrorLabel.snp.bottom).offset(26)
        }

        descriptionTextField.snp.makeConstraints {
            $0.height.equalTo(64)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(descriptionLabel.snp.bottom)
        }

        descriptionErrorLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionTextField.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }

        nextButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(62)
        }
    }

    private func addPaddingToTextField(_ textField: UITextField) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.rightView = paddingView
        textField.rightViewMode = .always
    }

    // MARK: Actions

    @objc func onNextTap() {
        interactor?.didTapContinueButton(title: titleTextField.text, description: descriptionTextField.text)
    }
}

extension NewRoutineViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        titleErrorLabel.isHidden = true
        titleErrorLabel.layer.borderColor = UIColor.lightGray.cgColor
        descriptionErrorLabel.isHidden = true
        descriptionTextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        titleErrorLabel.isHidden = true
        titleErrorLabel.layer.borderColor = UIColor.black.cgColor
        descriptionErrorLabel.isHidden = true
        descriptionTextField.layer.borderColor = UIColor.black.cgColor
        return true
    }
}

extension NewRoutineViewController {
    func displayErrorOnTitle(message: String) {
        titleErrorLabel.text = message
        titleErrorLabel.isHidden = false
        titleErrorLabel.layer.borderColor = UIColor.systemRed.cgColor
    }

    func displayErrorOnDescription(message: String) {
        descriptionErrorLabel.text = message
        descriptionErrorLabel.isHidden = false
        descriptionTextField.layer.borderColor = UIColor.systemRed.cgColor
    }
}
