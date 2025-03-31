//
//  SelectBackgroundSoundViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/06/23.
//

import UIKit
import SnapKit

protocol SelectBackgroundSoundViewControlling {}

final class SelectBackgroundSoundViewController: BaseViewController, SelectBackgroundSoundViewControlling {
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Selecione um tipo de áudio para acompanhar sua rotina"
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
        collection.register(SoundCell.self, forCellWithReuseIdentifier: SoundCell.identifier)
        return collection
    }()

    private lazy var noButton: UIButton = {
        let button = UIButton()
        button.setTitle("Não vou usar som", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(self.onTapNotUsingButton), for: .touchUpInside)
        return button
    }()

    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continuar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(self.onNextTap), for: .touchUpInside)
        return button
    }()

    var interactor: SelectBackgroundSoundInteracting?

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
    @objc func onTapNotUsingButton() {
        interactor?.didTapOnNotUsingSound()
    }

    @objc func onNextTap() {
        interactor?.didTapContinue()
    }
}

extension SelectBackgroundSoundViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor?.getDataSourceCount() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.didSelectAudio(at: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SoundCell.identifier, for: indexPath) as? SoundCell,
           let soundConfig = interactor?.getSoundConfig(for: indexPath.row) {
            cell.setupCell(with: soundConfig)
            return cell
        }

        return UICollectionViewCell()
    }
}

extension SelectBackgroundSoundViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
}
