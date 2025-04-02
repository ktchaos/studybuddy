//
//  SelectAppsToBlockViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/06/23.
//

import UIKit
import SnapKit
import ManagedSettings
import FamilyControls
import SwiftUI

class SelectAppsToBlockViewController: BaseViewController {
    private var selection = FamilyActivitySelection()
    private let store = ManagedSettingsStore()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Escolha alguns aplicativos para serem bloqueados durante seu tempo de foco"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 19)
        label.textColor = .black
        return label
    }()
    
    private lazy var selectAppsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Selecionar Aplicativos", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(openActivityPicker), for: .touchUpInside)
        return button
    }()
    
    lazy var finishButton: UIButton = {
        let button = UIButton()
        button.setTitle("Criar rotina", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(self.onNextTap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViews()
        requestAuthorization()
    }
    
    private func setupUI() {
        title = "Selecionar Aplicativos"
        view.backgroundColor = .systemBackground
    }
    
    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(selectAppsButton)
        view.addSubview(finishButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.height.equalTo(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        selectAppsButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(50)
        }
        
        finishButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(50)
        }
    }
    
    private func requestAuthorization() {
        Task {
            do {
                try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
            } catch {
                print("Failed to request authorization: \(error)")
            }
        }
    }
    
    @objc private func openActivityPicker() {
        let picker = FamilyActivityPicker(selection: Binding(get: { self.selection }, set: { self.selection = $0 }))
        let hostingController = UIHostingController(rootView: picker)
        hostingController.modalPresentationStyle = .fullScreen
        
        let navigationController = UINavigationController(rootViewController: hostingController)
        hostingController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissPicker))
        present(navigationController, animated: true)
    }
    
    @objc private func dismissPicker() {
        dismiss(animated: true)
    }
    
    @objc func onNextTap() {
        if selection.applicationTokens.isEmpty {
            let alert = UIAlertController(
                title: "Atenção",
                message: "Por favor, selecione pelo menos um aplicativo para bloquear.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}
