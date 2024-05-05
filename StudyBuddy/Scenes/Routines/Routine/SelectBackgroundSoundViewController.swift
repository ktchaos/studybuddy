//
//  SelectBackgroundSoundViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/06/23.
//

import UIKit
import SnapKit

class SelectBackgroundSoundViewController: UIViewController {
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Selecione um som para acompanhar sua rotina"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 19)//UIFont(name: "Courier New", size: 15)
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
        collection.register(SoundCell.self, forCellWithReuseIdentifier: SoundCell.identifier)
        return collection
    }()

    private lazy var noButton: UIButton = {
        let button = UIButton()
        button.setTitle("Não vou usar som", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)//UIFont(name: "Courier New", size: 20)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(self.onNextTap), for: .touchUpInside)
        return button
    }()

    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continuar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)//UIFont(name: "Courier New", size: 20)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(self.onNextTap), for: .touchUpInside)
        return button
    }()

    let dataSource = [
        Sound(image: UIImage(named: "lib") ?? UIImage(), name: "Biblioteca"),
        Sound(image: UIImage(named: "nat") ?? UIImage(), name: "Natureza"),
        Sound(image: UIImage(named: "freq") ?? UIImage(), name: "Frequências"),
        Sound(image: UIImage(named: "rain") ?? UIImage(), name: "Chuva")
    ]

    var routine: Routine?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViews()
    }

    func setupUI() {
        title = "Áudio"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
    }

    func setupViews() {
        addShadow(view: noButton)
        addShadow(view: nextButton)
        view.addSubview(descriptionLabel)
        view.addSubview(noButton)
        view.addSubview(nextButton)
        view.addSubview(soundsColletionView)

        descriptionLabel.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(150)
        }

        nextButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(42)
        }

        noButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(nextButton.snp.top).offset(-16)
        }

        soundsColletionView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(noButton.snp.top)
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
        let selectAppsToBlockViewController = SelectAppsToBlockViewController()
        self.navigationController?.pushViewController(selectAppsToBlockViewController, animated: true)
    }
}

extension SelectBackgroundSoundViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sound = dataSource[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SoundCell.identifier, for: indexPath) as? SoundCell {
            cell.setupCell(with: sound)
            return cell
        }

        let celllala = UICollectionViewCell()
        celllala.backgroundColor = .red
        return celllala
    }
}

extension SelectBackgroundSoundViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
}
