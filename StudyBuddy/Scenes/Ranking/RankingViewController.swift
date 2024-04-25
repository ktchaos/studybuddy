//
//  RankingViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 23/04/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RankingViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ranking geral SB"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
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

    var dataSource: [UserOnRankingCell] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupTableView()
        self.navigationController?.navigationBar.tintColor = .black
    }

    func setupTableView() {
        self.dataSource = setupCells()
    }

    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(tableView)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(16)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(54)
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}

extension RankingViewController {
    private func setupCells() -> [UserOnRankingCell] {
        let user1 = UserOnRanking(username: "@dummyUser03", userPicture: "", position: "1")
        let user2 = UserOnRanking(username: "@smartUserR24", userPicture: "", position: "2")
        let user3 = UserOnRanking(username: "@janedoe_", userPicture: "", position: "3")
        let user4 = UserOnRanking(username: "@john-silva", userPicture: "", position: "4")
        let user5 = UserOnRanking(username: "@thebuddymaster33", userPicture: "", position: "5")

        let user1Cell = UserOnRankingCell()
        user1Cell.userOnRanking = user1

        let user2Cell = UserOnRankingCell()
        user2Cell.userOnRanking = user2

        let user3Cell = UserOnRankingCell()
        user3Cell.userOnRanking = user3

        let user4Cell = UserOnRankingCell()
        user4Cell.userOnRanking = user4

        let user5Cell = UserOnRankingCell()
        user5Cell.userOnRanking = user5


        return [user1Cell, user2Cell, user3Cell, user4Cell, user5Cell]
    }
}

extension RankingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let userOnRanking = self.dataSource[indexPath.row].userOnRanking, let cell = tableView.dequeueReusableCell(withIdentifier: UserOnRankingCell.identifier, for: indexPath) as? UserOnRankingCell {
            cell.setupCell(with: userOnRanking)
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}
