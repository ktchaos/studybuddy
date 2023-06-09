//
//  RoutineDetailsViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/06/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RoutineDetailsViewController: UIViewController {
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    var routine: Routine?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViews()
    }

    func setupUI() {
        title = routine?.nameOfTheRoutine
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
    }

    func setupViews() {
        view.addSubview(addButton)

        addButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.leading.equalToSuperview().offset(16)
            $0.height.width.equalTo(32)
        }

        
    }
}
