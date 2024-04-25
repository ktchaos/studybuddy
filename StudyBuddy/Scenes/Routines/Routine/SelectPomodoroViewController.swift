//
//  SelectPomodoroViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/06/23.
//

import UIKit
import SnapKit

class SelectPomodoroViewController: UIViewController {
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Para 2 horas, sugerimos esses dois tipos de configuração para utilizar o pomodoro.\n\nSelecione a quantidade de sessões:"
        label.numberOfLines = 0
        label.font = UIFont(name: "Courier New", size: 19)
        label.textColor = .black
        return label
    }()

    // MARK: First Option
    private lazy var sessionOneTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "4 sessões"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Courier New", size: 20)
        label.textColor = .black
        return label
    }()

    private lazy var sessionOneDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "(25 minutos de foco + 5 minutos de descanso)"
        label.numberOfLines = 0
        let font = UIFont(name: "Courier New", size: 15)
        label.font = font
        label.textColor = .black
        return label
    }()

    private lazy var helperOneStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [sessionOneTitleLabel, sessionOneDescriptionLabel])
        stack.axis = .vertical
        stack.spacing = 6
        return stack
    }()

    lazy var toggleOne: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = false
        toggle.isEnabled = true
        toggle.addTarget(self, action: #selector(self.switchValueDidChange), for: .valueChanged)
        toggle.tag = 1
        return toggle
    }()

    private lazy var optionOneStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [helperOneStackView, toggleOne])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.backgroundColor = .systemGray6
        stack.layer.cornerRadius = 5
        return stack
    }()

    // MARK: Second Option
    private lazy var sessionTwoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "2 sessões"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Courier New", size: 20)
        label.textColor = .black
        return label
    }()

    private lazy var sessionTwoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "(50 minutos de foco + 10 minutos de descanso)"
        label.numberOfLines = 0
        let font = UIFont(name: "Courier New", size: 15)
        label.font = font
        label.textColor = .black
        return label
    }()

    private lazy var helperTwoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [sessionTwoTitleLabel, sessionTwoDescriptionLabel])
        stack.axis = .vertical
        stack.spacing = 6
        return stack
    }()

    lazy var toggleTwo: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = false
        toggle.isEnabled = true
        toggle.tag = 2
        toggle.addTarget(self, action: #selector(self.switchValueDidChange), for: .valueChanged)
        return toggle
    }()

    private lazy var optionTwoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [helperTwoStackView, toggleTwo])
        stack.axis = .horizontal
        stack.distribution = .fill

        stack.backgroundColor = .systemGray6
        stack.layer.cornerRadius = 5
        return stack
    }()

    private lazy var noButton: UIButton = {
        let button = UIButton()
        button.setTitle("Não vou usar pomodoro", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Courier New", size: 20)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(self.onNextTap), for: .touchUpInside)
        return button
    }()

    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continuar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Courier New", size: 20)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(self.onNextTap), for: .touchUpInside)
        return button
    }()

    var routine: Routine?

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
        addShadow(view: noButton)
        addShadow(view: nextButton)
        addShadow(view: optionOneStackView)
        addShadow(view: optionTwoStackView)
        view.addSubview(descriptionLabel)
        view.addSubview(noButton)
        view.addSubview(nextButton)
        view.addSubview(optionOneStackView)
        view.addSubview(optionTwoStackView)

        descriptionLabel.snp.makeConstraints {
            $0.height.equalTo(124)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(150)
        }

        optionOneStackView.snp.makeConstraints {
            $0.height.equalTo(64)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(32)
        }

        optionTwoStackView.snp.makeConstraints {
            $0.height.equalTo(64)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(optionOneStackView.snp.bottom).offset(16)
        }

        nextButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(42)
        }

        noButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(nextButton.snp.top).offset(-16)
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
        let selectBackgroundSoundViewController = SelectBackgroundSoundViewController()
        self.navigationController?.pushViewController(selectBackgroundSoundViewController, animated: true)
    }
}

extension SelectPomodoroViewController {
    @objc func switchValueDidChange(sender:UISwitch!) {
        switch sender.tag {
        case 1:
            toggleTwo.isOn = false
        case 2:
            toggleOne.isOn = false
        default:
            return
        }
    }
}
