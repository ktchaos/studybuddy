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
        label.text = "About Study Buddy"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()

    private lazy var tipOneLabel: UILabel = {
        let label = UILabel()
        label.text = "Study Buddy is an app developed to help you stay focused on your studies. It allows you to block distracting apps during specific periods and is based on a technique similar to the Pomodoro method, breaking your time into focus sessions and breaks. You can create personalized routines and earn points as you follow them — don’t worry about keeping track, the app handles that for you. Enjoy Study Buddy and happy studying! 💪📚"
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

    private lazy var gotItButton: UIButton = {
        let button = UIButton()
        button.setTitle("Got it", for: .normal)
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

