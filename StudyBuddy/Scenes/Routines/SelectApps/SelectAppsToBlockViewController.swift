//
//  SelectAppsToBlockViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/06/23.
//

import UIKit
import SnapKit
import ManagedSettings

class SelectAppsToBlockViewController: BaseViewController {
    private let shieldManager = ShieldManager()
    private var selectedApps: Set<ApplicationToken> = []
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Selecione os aplicativos que deseja bloquear durante esta rotina"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 19)
        label.textColor = .black
        return label
    }()
    
    private lazy var selectAppsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Selecionar Aplicativos", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
//        button.addTarget(self, action: #selector(openActivityPicker), for: .touchUpInside)
        return button
    }()
    
    lazy var finishButton: UIButton = {
        let button = UIButton()
        button.setTitle("Criar rotina", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(self.onNextTap), for: .touchUpInside)
        return button
    }()

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
        view.addSubview(descriptionLabel)
        view.addSubview(selectAppsButton)
        view.addSubview(finishButton)

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }

        selectAppsButton.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
        }

        finishButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }

    
    
    @objc func onNextTap() {
        // Create the routine with the selected apps
        if !selectedApps.isEmpty {
            // Here you would create the routine with the selected apps
            // You might want to pass this data back to the previous screen
            // or create the routine directly
            navigationController?.popViewController(animated: true)
        } else {
            // Show an alert to select apps first
            let alert = UIAlertController(
                title: "Selecione aplicativos",
                message: "Por favor, selecione pelo menos um aplicativo para bloquear.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}
