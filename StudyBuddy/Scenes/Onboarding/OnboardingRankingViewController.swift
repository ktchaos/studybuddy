//
//  OnboardingRankingViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 02/05/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class OnboardingRankingViewController: UIViewController {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()

    private lazy var tipOneLabel: UILabel = {
        let label = UILabel()
        label.text = "- Crie rotinas para acompanhar seus momentos de foco."
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private lazy var tipTwoLabel: UILabel = {
        let label = UILabel()
        label.text = "- Utilize pomodoro, sons em background e bloqueie aplicativos."
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private lazy var tipThreeLabel: UILabel = {
        let label = UILabel()
        label.text = "- Complete suas rotinas e acumule SB points."
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private lazy var tipFourLabel: UILabel = {
        let label = UILabel()
        label.text = "- Com SB points, você participa automaticamente do ranking geral dos usuários."
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continuar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 8
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(self.onRankingTap), for: .touchUpInside)
        return button
    }()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(tipOneLabel)
        view.addSubview(tipTwoLabel)
        view.addSubview(tipThreeLabel)
        view.addSubview(tipFourLabel)
        view.addSubview(continueButton)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(16)
        }

        tipOneLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
        }

        tipTwoLabel.snp.makeConstraints {
            $0.top.equalTo(tipOneLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
        }

        tipThreeLabel.snp.makeConstraints {
            $0.top.equalTo(tipTwoLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
        }

        tipFourLabel.snp.makeConstraints {
            $0.top.equalTo(tipThreeLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
        }

        continueButton.snp.makeConstraints {
            $0.top.equalTo(tipFourLabel.snp.bottom).offset(42)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
        }
    }

    @objc func onRankingTap() {
        let coordinator = MainFactory.make()
        self.navigationController?.modalPresentationStyle = .fullScreen
        self.navigationController?.present(coordinator.rootViewController, animated: true)
    }
}
