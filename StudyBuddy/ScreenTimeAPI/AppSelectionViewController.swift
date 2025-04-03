import UIKit
import SwiftUI
import FamilyControls
import Foundation
import ManagedSettings

protocol AppSelectionViewControllerDelegate: AnyObject {
    func appSelectionViewController(_ viewController: AppSelectionViewController, didFinishWith selection: FamilyActivitySelection)
    func appSelectionViewControllerDidCancel(_ viewController: AppSelectionViewController)
}

class AppSelectionViewController: BaseViewController {
    weak var delegate: AppSelectionViewControllerDelegate?
    private var selection = FamilyActivitySelection()
    private let store = ManagedSettingsStore()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AppCell.self, forCellReuseIdentifier: AppCell.identifier)
        tableView.allowsMultipleSelection = true
        return tableView
    }()
    
    private lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Concluir", style: .done, target: self, action: #selector(doneButtonTapped))
        return button
    }()
    
    private lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelButtonTapped))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViews()
        loadInstalledApps()
    }
    
    private func setupUI() {
        title = "Selecionar Aplicativos"
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
        view.backgroundColor = .white
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func loadInstalledApps() {
        // Get all installed apps using FamilyControls
        Task {
            do {
                let center = AuthorizationCenter.shared
                if center.authorizationStatus == .approved {
                    // Get the current selection which includes all installed apps
                    selection = center.authorizationStatus == .approved ? FamilyActivitySelection() : FamilyActivitySelection()
                    tableView.reloadData()
                }
            } catch {
                print("Failed to load apps: \(error)")
            }
        }
    }
    
    @objc private func doneButtonTapped() {
        delegate?.appSelectionViewController(self, didFinishWith: selection)
    }
    
    @objc private func cancelButtonTapped() {
        delegate?.appSelectionViewControllerDidCancel(self)
    }
}

extension AppSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selection.applicationTokens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppCell.identifier, for: indexPath) as! AppCell
        let appToken = selection.applicationTokens[indexPath.row]
        
        // Create an App object with the token's information
        let app = App(
            icon: UIImage(systemName: "app.fill") ?? UIImage(),
            applicationName: appToken.localizedDisplayName ?? "Unknown App"
        )
        
        cell.setupCell(with: app)
        cell.toggle.isOn = selection.applicationTokens.contains(appToken)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appToken = selection.applicationTokens[indexPath.row]
        selection.applicationTokens.insert(appToken)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let appToken = selection.applicationTokens[indexPath.row]
        selection.applicationTokens.remove(appToken)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}