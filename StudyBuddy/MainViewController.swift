//
//  ViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 18/05/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
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
        return tableView
    }()

    var dataSource: [RoutineCell] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViews()
        setupTableView()
        setupNavigation()
    }

    func setupUI() {
        title = "Minhas rotinas"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
    }

    func setupNavigation() {
        self.navigationController?.navigationBar.tintColor = .black
    }

    func setupTableView() {
        self.dataSource = setupCells()
    }

    func setupViews() {
        view.addSubview(addButton)
        view.addSubview(routineTableView)

        addButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.leading.equalToSuperview().offset(16)
            $0.height.width.equalTo(32)
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
        let newRoutineViewController = NewRoutineViewController()
        self.navigationController?.pushViewController(newRoutineViewController, animated: true)
    }

    func createLastRoutine() {
        let newRoutineCell = RoutineCell()
        let newRoutine = Routine(nameOfTheRoutine: "Foco na aula", rangeTime: "2 horas")
        newRoutineCell.routine = newRoutine
        self.dataSource.append(newRoutineCell)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.routineTableView.reloadData()
        }
    }
}

extension MainViewController {
    private func setupCells() -> [RoutineCell] {
        let routine1 = Routine(nameOfTheRoutine: "Hora do foco!", rangeTime: "5 horas")
        let routine2 = Routine(nameOfTheRoutine: "Leitura", rangeTime: "2 horas")
        let routine3 = Routine(nameOfTheRoutine: "Meditação", rangeTime: "30 minutos")

        let routine1Cell = RoutineCell()
        routine1Cell.routine = routine1

        let routine2Cell = RoutineCell()
        routine2Cell.routine = routine2

        let routine3Cell = RoutineCell()
        routine3Cell.routine = routine3

        return [routine1Cell, routine2Cell, routine3Cell]
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let routine = self.dataSource[indexPath.row].routine, let cell = tableView.dequeueReusableCell(withIdentifier: RoutineCell.identifier, for: indexPath) as? RoutineCell {
            cell.setupCell(with: routine)
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let routine = self.dataSource[indexPath.row].routine
        let detailsViewController = RoutineDetailsViewController()
        detailsViewController.routine = routine
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
