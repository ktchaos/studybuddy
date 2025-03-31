//
//  HelpViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 02/05/24.
//

import UIKit
import SnapKit

class HelpViewController: BaseViewController {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sobre a aplicação"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()

    private lazy var tipOneLabel: UILabel = {
        let label = UILabel()
        label.text = "O Study Buddy é um aplicativo móvel criado pela desenvolvedora Catarina Serrano para gerenciar e bloquear aplicativos durante um determinado período de tempo. Além de uma espécie de pomodoro baseado em sessões que irá auxilia em momentos em que são necessários total foco e concentração. Você pode criar e utilizar rotinas para acumular pontos, esses pontos são calculados internamente, então não se preocupe com isso. Aproveite o Study Buddy e bons estudos!"
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

    private lazy var gotItButton: UIButton = {
        let button = UIButton()
        button.setTitle("Entendi", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 8
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(self.onRankingTap), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(tipOneLabel)
        view.addSubview(gotItButton)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }

        tipOneLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
        }

        gotItButton.snp.makeConstraints {
            $0.top.equalTo(tipOneLabel.snp.bottom).offset(42)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
        }
    }

    @objc func onRankingTap() {
        self.navigationController?.popViewController(animated: true)
    }
}

