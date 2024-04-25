//
//  EditRoutineViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 24/04/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class EditRoutineViewController: UIViewController {
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "Courier New", size: 20)
        textField.textColor = .black
        return textField
    }()
    private lazy var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "Courier New", size: 20)
        textField.textColor = .black
        return textField
    }()
    private lazy var pomodoroLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "  Pomodoro"
        label.numberOfLines = 0
        label.font = UIFont(name: "Courier New", size: 17)
        return label
    }()
    private lazy var pomodoroToggle: UIButton = {
        let button = UIButton()
        button.setTitle("Editar  >", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textColor = .black
        button.addTarget(self, action: #selector(self.didTapEditPomodoro), for: .touchUpInside)
        return button
    }()
    private lazy var helperView1: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    private lazy var helperView3: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    private lazy var v1Stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [helperView1, pomodoroToggle])
        stack.axis = .vertical
        return stack
    }()
    private lazy var pomodoroStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [pomodoroLabel, v1Stack, helperView3])
        stack.axis = .horizontal
        stack.layer.borderWidth = 0.1
        stack.layer.cornerRadius = 8
        stack.backgroundColor = .systemGray6
        return stack
    }()
    private lazy var soundLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "  Som em background"
        label.numberOfLines = 0
        label.font = UIFont(name: "Courier New", size: 17)
        return label
    }()
    private lazy var soundToggle: UIButton = {
        let button = UIButton()
        button.setTitle("Editar  >", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textColor = .black
        button.addTarget(self, action: #selector(self.didTapEditSound), for: .touchUpInside)
        return button
    }()
    private lazy var helperView2: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    private lazy var helperView4: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    private lazy var v2Stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [helperView2, soundToggle])
        stack.axis = .vertical
        return stack
    }()

    private lazy var soundStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [soundLabel, v2Stack, helperView4])
        stack.axis = .horizontal
        stack.layer.borderWidth = 0.1
        stack.layer.cornerRadius = 8
        stack.backgroundColor = .systemGray6
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
    private lazy var appsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AppCell.self, forCellReuseIdentifier: AppCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = true
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
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


    var routine: Routine?

    let dataSource = [
        App(icon: UIImage(named: "zap") ?? UIImage(), applicationName: "WhatsApp"),
        App(icon: UIImage(named: "insta") ?? UIImage(), applicationName: "Instagram"),
        App(icon: UIImage(named: "telegram") ?? UIImage(), applicationName: "Telegram"),
        App(icon: UIImage(named: "linkedin") ?? UIImage(), applicationName: "LinkedIn"),
    ]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViews()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
    }

    func setupUI() {
        title = routine?.titleOfRoutine
        navigationController?.navigationBar.prefersLargeTitles = true
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
        view.addSubview(appsTableView)

        helperView1.snp.makeConstraints {
            $0.height.equalTo(6)
        }

        helperView2.snp.makeConstraints {
            $0.height.equalTo(6)
        }

        helperView3.snp.makeConstraints {
            $0.width.equalTo(6)
        }

        helperView4.snp.makeConstraints {
            $0.width.equalTo(6)
        }

        pomodoroToggle.snp.makeConstraints {
            $0.width.equalTo(56)
        }

        soundToggle.snp.makeConstraints {
            $0.width.equalTo(56)
        }

        titleTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
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

        appsTableView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(blockedAppsButton.snp.bottom).offset(16)
            $0.bottom.equalToSuperview()
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

extension EditRoutineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let app = self.dataSource[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: AppCell.identifier, for: indexPath) as? AppCell {
            cell.setupCell(with: app)
            cell.toggle.isHidden = true
            return cell
        }

        return UITableViewCell()
    }
}

extension EditRoutineViewController {
    @objc func didTapSaveButton() {

    }

    @objc func didTapEditSound() {
        let soundVC = SelectBackgroundSoundViewController()
        soundVC.nextButton.isHidden = true
        navigationController?.pushViewController(soundVC, animated: true)
    }

    @objc func didTapEditPomodoro() {
        let pomodoroVC = SelectPomodoroViewController()
        pomodoroVC.nextButton.isHidden = true
        navigationController?.pushViewController(pomodoroVC, animated: true)
    }

    @objc func didTapEditAppsButton() {
        let selectAppsVC = SelectAppsToBlockViewController()
        selectAppsVC.finishButton.setTitle("Salvar", for: .normal)
        navigationController?.pushViewController(selectAppsVC, animated: true)
    }
}
