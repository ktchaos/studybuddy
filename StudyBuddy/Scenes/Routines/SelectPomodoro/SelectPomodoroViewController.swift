//
//  SelectPomodoroViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/06/23.
//

import UIKit
import SnapKit

protocol SelectPomodoroViewControlling {
    func updateSessionsLabel(with number: String)
    func disableMinusButton()
    func disablePlusButton()
    func enableMinusButton()
    func enablePlusButton()
}

class SelectPomodoroViewController: BaseViewController, SelectPomodoroViewControlling {
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Cada sessão é composta de 50 minutos de foco e 10 minutos de intervalo.\n\nSelecione a quantidade de sessões:"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 19)
        label.textColor = .black
        return label
    }()
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continuar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(self.onNextTap), for: .touchUpInside)
        return button
    }()
    private lazy var sessionsNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.systemGray3.cgColor
        return label
    }()
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.isEnabled = false
        button.setBackgroundImage(minusImage, for: .normal)
        button.addTarget(self, action: #selector(self.onMinusTap), for: .touchUpInside)
        return button
    }()
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(plusImage, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(self.onPlusTap), for: .touchUpInside)
        return button
    }()
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [minusButton, sessionsNumberLabel, plusButton])
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fill
        return stack
    }()

    private let minusImage = UIImage(systemName: "minus.circle")
    private let plusImage = UIImage(systemName: "plus.circle")

    var interactor: SelectPomodoroInteracting?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViews()
    }

    func setupUI() {
        title = "Pomodoro"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
    }

    func setupViews() {
        addShadow(view: nextButton)
        view.addSubview(descriptionLabel)
        view.addSubview(buttonsStackView)
        view.addSubview(nextButton)

        descriptionLabel.snp.makeConstraints {
            $0.height.equalTo(124)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(150)
        }

        minusButton.snp.makeConstraints {
            $0.width.equalTo(54)
        }

        plusButton.snp.makeConstraints {
            $0.width.equalTo(54)
        }

        sessionsNumberLabel.snp.makeConstraints {
            $0.width.equalTo(64)
        }

        buttonsStackView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(62)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(54)
        }

        nextButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(62)
        }
    }

    func addShadow(view: UIView, shadowColor: CGColor = UIColor.black.cgColor, shadowOffset: CGSize = .zero, shadowOpacity: Float = 0.5, shadowRadius: CGFloat = 5.0) {
        view.layer.shadowColor = shadowColor
        view.layer.shadowOffset = shadowOffset
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowRadius = shadowRadius
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 5
    }

    // MARK: Actions

    @objc func onNextTap() {
        interactor?.didTapContinue()
    }

    @objc func onMinusTap() {
        interactor?.didTapMinusButton()
    }
    
    @objc func onPlusTap() {
        interactor?.didTapPlusButton()
    }

    func updateSessionsLabel(with number: String) {
        sessionsNumberLabel.text = number
    }

    func disableMinusButton() {
        minusButton.isEnabled = false
    }

    func disablePlusButton() {
        plusButton.isEnabled = false
    }

    func enableMinusButton() {
        minusButton.isEnabled = true
    }

    func enablePlusButton() {
        plusButton.isEnabled = true
    }
}
