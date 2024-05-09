//
//  ProfilePictureSelectionViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/05/24.
//

import UIKit

final class ProfilePictureSelectionViewController: UIViewController {
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Selecione uma imagem para o seu perfil"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 19)
        label.textColor = .black
        return label
    }()

    private lazy var soundsColletionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 111, height: 111)
        let collection = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(ProfilePictureSelectionCell.self, forCellWithReuseIdentifier: ProfilePictureSelectionCell.identifier)
        return collection
    }()

    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Salvar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(self.onNextTap), for: .touchUpInside)
        return button
    }()

    var delegate: PictureSelectionDelegate?

    let dataSource: [ProfilePicture] = [
        ProfilePicture(systemName: "book.closed.circle.fill", image: UIImage(systemName: "book.closed.circle.fill")),
        ProfilePicture(systemName: "dumbbell.fill", image: UIImage(systemName: "dumbbell.fill")),
        ProfilePicture(systemName: "baseball.fill", image: UIImage(systemName: "baseball.fill")),
        ProfilePicture(systemName: "eye.trianglebadge.exclamationmark", image: UIImage(systemName: "eye.trianglebadge.exclamationmark")),
        ProfilePicture(systemName: "figure.child.and.lock.fill", image: UIImage(systemName: "figure.child.and.lock.fill")),
        ProfilePicture(systemName: "dog.fill", image: UIImage(systemName: "dog.fill")),
        ProfilePicture(systemName: "car", image: UIImage(systemName: "car")),
        ProfilePicture(systemName: "iphone.smartbatterycase.gen1", image: UIImage(systemName: "iphone.smartbatterycase.gen1")),
        ProfilePicture(systemName: "sparkles.tv", image: UIImage(systemName: "sparkles.tv")),
        ProfilePicture(systemName: "wave.3.forward.circle.fill", image: UIImage(systemName: "wave.3.forward.circle.fill")),
        ProfilePicture(systemName: "gamecontroller", image: UIImage(systemName: "gamecontroller")),
        ProfilePicture(systemName: "arcade.stick.console.fill", image: UIImage(systemName: "arcade.stick.console.fill")),
        ProfilePicture(systemName: "cup.and.saucer.fill", image: UIImage(systemName: "cup.and.saucer.fill")),
        ProfilePicture(systemName: "paintpalette.fill", image: UIImage(systemName: "paintpalette.fill")),
        ProfilePicture(systemName: "fossil.shell.fill", image: UIImage(systemName: "fossil.shell.fill")),
        ProfilePicture(systemName: "hourglass.circle", image: UIImage(systemName: "hourglass.circle")),
        ProfilePicture(systemName: "battery.100percent.bolt", image: UIImage(systemName: "battery.100percent.bolt")),
        ProfilePicture(systemName: "gauge.low", image: UIImage(systemName: "gauge.low")),
        ProfilePicture(systemName: "terminal", image: UIImage(systemName: "terminal")),
        ProfilePicture(systemName: "cube.transparent", image: UIImage(systemName: "cube.transparent")),
        ProfilePicture(systemName: "beats.headphones", image: UIImage(systemName: "beats.headphones")),
        ProfilePicture(systemName: "visionpro", image: UIImage(systemName: "visionpro")),
        ProfilePicture(systemName: "laptopcomputer", image: UIImage(systemName: "laptopcomputer")),
        ProfilePicture(systemName: "tent.fill", image: UIImage(systemName: "tent.fill"))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViews()
    }

    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
    }

    func setupViews() {
        addShadow(view: nextButton)
        view.addSubview(descriptionLabel)
        view.addSubview(nextButton)
        view.addSubview(soundsColletionView)

        descriptionLabel.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(24)
        }

        soundsColletionView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(nextButton.snp.top)
        }

        nextButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(42)
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
        self.dismiss(animated: true)
    }
}

extension ProfilePictureSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.getSelectedImage(profilePicture: dataSource[indexPath.row])
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfilePictureSelectionCell.identifier, for: indexPath) as? ProfilePictureSelectionCell {
            cell.setupCell(with: dataSource[indexPath.row].image ?? UIImage())
            return cell
        }

        return UICollectionViewCell()
    }
}

extension ProfilePictureSelectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
}
