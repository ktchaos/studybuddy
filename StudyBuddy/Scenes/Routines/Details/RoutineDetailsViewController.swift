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

final class RoutineDetailsViewController: UIViewController, RoutineDetailsViewControlling {
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
        button.setTitle(" Começar rotina ", for: .normal)
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
        label.text = "  Som em background"
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
    private lazy var blockedAppsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Os aplicativos a seguir estarão bloqueados"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        return label
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

    var interactor: RoutineDetailsInteractor?

    let dataSource = [
        App(icon: UIImage(named: "zap") ?? UIImage(), applicationName: "WhatsApp"),
        App(icon: UIImage(named: "insta") ?? UIImage(), applicationName: "Instagram"),
        App(icon: UIImage(named: "telegram") ?? UIImage(), applicationName: "Telegram"),
        App(icon: UIImage(named: "linkedin") ?? UIImage(), applicationName: "LinkedIn"),
    ]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViews()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editButton)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }

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
        view.addSubview(blockedAppsLabel)
        view.addSubview(appsTableView)
        view.addSubview(startButton)

        view.bringSubviewToFront(editButton)


        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.width.equalTo(54)
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

        blockedAppsLabel.snp.makeConstraints {
            $0.top.equalTo(soundStack.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(60)
        }

        appsTableView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(blockedAppsLabel.snp.bottom).offset(16)
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

extension RoutineDetailsViewController: UITableViewDelegate, UITableViewDataSource {
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

extension RoutineDetailsViewController {
    @objc func didTapEditButton() {
        interactor?.didTapEditButton()
    }

    @objc func didTapStartButton() {
        interactor?.onStartButtonTap()
    }
}
