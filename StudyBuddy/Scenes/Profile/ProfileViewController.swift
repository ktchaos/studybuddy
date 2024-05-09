//
//  ProfileViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 22/04/24.
//

import UIKit
import SnapKit

protocol ProfileViewControlling {
    func updateTotalPointsLabel(with totalPointsText: String)
    func updateProfilePicture(with image: UIImage)
}

protocol PictureSelectionDelegate {
    func getSelectedImage(profilePicture: ProfilePicture)
}

class ProfileViewController: UIViewController, ProfileViewControlling, PictureSelectionDelegate {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Meu Perfil"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()

    private lazy var profileIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.tintColor = .darkGray
        imageView.layer.cornerRadius = 5
        imageView.layer.borderWidth = 1.5
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTapOnProfileImage))
        imageView.addGestureRecognizer(tap)
        return imageView
    }()

    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private lazy var myScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Pontuação atual:"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    private lazy var totalScoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()

    private lazy var rankingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ver ranking", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 8
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(self.onRankingTap), for: .touchUpInside)
        return button
    }()

    private lazy var helpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ajuda", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 8
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(self.onHelpTap), for: .touchUpInside)
        return button
    }()

    var interactor: ProfileInteracting?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupUI()
    }

    func setupUI() {
        usernameLabel.text = interactor?.getUsernameAndLoadPoints()
    }

    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(profileIconImageView)
        view.addSubview(usernameLabel)
        view.addSubview(myScoreLabel)
        view.addSubview(totalScoreLabel)
        view.addSubview(rankingButton)
        view.addSubview(helpButton)

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(16)
        }

        profileIconImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(42)
            $0.height.width.equalTo(120)
            $0.centerX.equalToSuperview()
        }

        usernameLabel.snp.makeConstraints {
            $0.top.equalTo(profileIconImageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }

        myScoreLabel.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom).offset(48)
            $0.centerX.equalToSuperview()
        }

        totalScoreLabel.snp.makeConstraints {
            $0.top.equalTo(myScoreLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }

        rankingButton.snp.makeConstraints {
            $0.top.equalTo(totalScoreLabel.snp.bottom).offset(100)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
        }

        helpButton.snp.makeConstraints {
            $0.top.equalTo(rankingButton.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(24)
        }
    }

    @objc func onRankingTap() {
        interactor?.onRankingTap()
    }

    @objc func onHelpTap() {
        interactor?.onHelpTap()
    }

    @objc func didTapOnProfileImage() {
        let viewController = ProfilePictureSelectionViewController()
        viewController.delegate = self
        self.navigationController?.present(viewController, animated: true)
    }

    func getSelectedImage(profilePicture: ProfilePicture) {
        profileIconImageView.image = profilePicture.image
        interactor?.saveUserImage(profilePicture)
    }
}

extension ProfileViewController {
    func updateTotalPointsLabel(with totalPointsText: String) {
        totalScoreLabel.text = totalPointsText
    }

    func updateProfilePicture(with image: UIImage) {
        profileIconImageView.image = image
    }
}
