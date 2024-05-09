//
//  ViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 18/05/23.
//

import UIKit
import SnapKit
import FamilyControls
import ManagedSettings

protocol MainViewControlling {
    
}

class MainViewController: UIViewController, MainViewControlling {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Minhas rotinas"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()

    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.tintColor = .black
        button.setTitle(" Criar rotina", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(self.onAddTap), for: .touchUpInside)
        return button
    }()

    private lazy var routineTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RoutineCell.self, forCellReuseIdentifier: RoutineCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        return tableView
    }()

    var interactor: MainInteracting?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }

    var discouragedSelections = FamilyActivitySelection()
    let store = ManagedSettingsStore()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        interactor?.viewDidAppear()
        routineTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViews()
        setupNavigation()

        shieldActivities()

//        let task = Task {
//            await self.askForAuthorization()
//        }
    }

    // TODO: Move this to interactor
    func shieldActivities() {
        // Clear to reset previous settings
        store.clearAllSettings()

        let applications = discouragedSelections.applicationTokens
        let categories = discouragedSelections.categoryTokens
        print("APLICATIONS -> ", applications)
        print("CATEGORIAS -> ", categories)

        store.shield.applications = applications.isEmpty ? nil : applications
        store.shield.applicationCategories = categories.isEmpty ? nil : .specific(categories)
        store.shield.webDomainCategories = categories.isEmpty ? nil : .specific(categories)
    }

    func askForAuthorization() async {
        do {
            try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
        } catch {
            print("Failed to get authorization: \(error)")
        }
    }

    // MARK: UI

    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
    }

    func setupNavigation() {
        self.navigationController?.navigationBar.tintColor = .black
    }

    func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(addButton)
        view.addSubview(routineTableView)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(16)
        }

        addButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(120)
            $0.height.equalTo(32)
        }

        routineTableView.snp.makeConstraints {
            $0.top.equalTo(addButton).offset(54)
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
    }

    // MARK: Actions
    @objc func onAddTap() {
        interactor?.didTapCreateRoutine()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interactor?.getDataSourceCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let (title, duration) = interactor?.getTitleAndDuration(for: indexPath.row),
           let cell = tableView.dequeueReusableCell(withIdentifier: RoutineCell.identifier, for: indexPath) as? RoutineCell {
            cell.setupCell(with: title, duration)
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.didSelectCell(at: indexPath.row)
    }
}
