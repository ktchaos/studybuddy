//
//  SelectAppsToBlockViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/06/23.
//

import UIKit
import SnapKit

class SelectAppsToBlockViewController: UIViewController {
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Selecione alguns aplicativos para bloquear temporariamente"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 19)//UIFont(name: "Courier New", size: 15)
        label.textColor = .black
        return label
    }()
    private lazy var tableView: UITableView = {
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
    lazy var finishButton: UIButton = {
        let button = UIButton()
        button.setTitle("Criar rotina", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)//UIFont(name: "Courier New", size: 20)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(self.onNextTap), for: .touchUpInside)
        return button
    }()

    let dataSource = [
        App(icon: UIImage(named: "zap") ?? UIImage(), applicationName: "WhatsApp"),
        App(icon: UIImage(named: "insta") ?? UIImage(), applicationName: "Instagram"),
        App(icon: UIImage(named: "telegram") ?? UIImage(), applicationName: "Telegram"),
        App(icon: UIImage(named: "linkedin") ?? UIImage(), applicationName: "LinkedIn"),
        App(icon: UIImage(named: "chrome") ?? UIImage(), applicationName: "Google Chrome"),
        App(icon: UIImage(named: "mail") ?? UIImage(), applicationName: "Mail"),
        App(icon: UIImage(named: "drive") ?? UIImage(), applicationName: "Drive"),
        App(icon: UIImage(named: "gmail") ?? UIImage(), applicationName: "Gmail"),
        App(icon: UIImage(named: "facetime") ?? UIImage(), applicationName: "Facetime"),
        App(icon: UIImage(named: "safari") ?? UIImage(), applicationName: "Safari"),
        App(icon: UIImage(named: "calendar") ?? UIImage(), applicationName: "Google Calendar"),
        App(icon: UIImage(named: "netflix") ?? UIImage(), applicationName: "Netflix"),
        App(icon: UIImage(named: "spot") ?? UIImage(), applicationName: "Spotify"),
        App(icon: UIImage(named: "youtube") ?? UIImage(), applicationName: "YouTube"),
        App(icon: UIImage(named: "googlemaps") ?? UIImage(), applicationName: "Google Maps"),
        App(icon: UIImage(named: "pod") ?? UIImage(), applicationName: "Podcasts"),
        App(icon: UIImage(named: "ifood") ?? UIImage(), applicationName: "iFood"),
        App(icon: UIImage(named: "hbo") ?? UIImage(), applicationName: "HBO Max"),
        App(icon: UIImage(named: "ze") ?? UIImage(), applicationName: "Zé Delivery"),
        App(icon: UIImage(named: "shopee") ?? UIImage(), applicationName: "Shopee"),
        App(icon: UIImage(named: "notion") ?? UIImage(), applicationName: "Notion"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViews()
    }

    func setupUI() {
        title = "Bloquear aplicativos"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
    }

    func setupViews() {
        addShadow(view: finishButton)
        view.addSubview(descriptionLabel)
        view.addSubview(finishButton)
        view.addSubview(tableView)

        descriptionLabel.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(150)
        }

        finishButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(42)
        }

        tableView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            $0.bottom.equalTo(finishButton.snp.top).offset(-16)
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
        let newRoutineViewController = UIAlertController(title: "Rotina criada!", message: "Sua rotina foi adicionada na lista", preferredStyle: .alert)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            guard let mainViewController = self.navigationController?.viewControllers.first as? MainViewController else {
                return
            }

//            mainViewController.createLastRoutine()
            self.navigationController?.popToViewController(mainViewController, animated: true)
            newRoutineViewController.dismiss(animated: true)
        }
        present(newRoutineViewController, animated: true)
    }
}

extension SelectAppsToBlockViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let app = self.dataSource[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: AppCell.identifier, for: indexPath) as? AppCell {
            cell.setupCell(with: app)
            return cell
        }

        return UITableViewCell()
    }
}
