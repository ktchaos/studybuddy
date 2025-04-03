//
//  RankingViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 23/04/24.
//

import UIKit
import SnapKit

protocol RankingViewControlling {}

class RankingViewController: BaseViewController, RankingViewControlling {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ranking geral SB"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Colocação geral dos usuários do Study Buddy"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .gray
        return label
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UserOnRankingCell.self, forCellReuseIdentifier: UserOnRankingCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        return tableView
    }()

    var interactor: RankingInteracting?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        interactor?.loadRanking { [weak self] in
            self?.tableView.reloadData()
        }
        self.navigationController?.navigationBar.tintColor = .black
    }

    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(tableView)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(16)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(44)
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}

extension RankingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.getDataSourceCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let userOnRanking = self.interactor?.getUser(at: indexPath.row),
           let cell = tableView.dequeueReusableCell(withIdentifier: UserOnRankingCell.identifier, for: indexPath) as? UserOnRankingCell {
            cell.setupCell(with: userOnRanking, position: (indexPath.row + 1))
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}
