//
//  SoundCell.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/06/23.
//

import UIKit

struct SoundConfig {
    var image: UIImage
    var name: String
    var path: String
}

final class SoundCell: UICollectionViewCell, Identifiable {
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [icon, nameLabel])
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()

    override var isSelected: Bool{
        didSet {
            if self.isSelected {
                self.backgroundColor = .systemGray4
            } else {
                self.backgroundColor = .systemGray6
            }
        }
    }

    var soundConfig: SoundConfig?

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup
    func setupSubviews() {
        addSubview(hStack)
    }

    func setupConstraints() {
        icon.snp.makeConstraints {
            $0.width.equalTo(64)
            $0.height.equalTo(64)
        }
        hStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.trailing.equalToSuperview().inset(6)
            $0.leading.equalToSuperview().inset(6)
        }
    }

    func setupCell(with sound: SoundConfig) {
        self.addShadow()
        icon.image = sound.image
        icon.tintColor = .black
        nameLabel.text = sound.name
        self.backgroundColor = .systemGray6
    }

    fileprivate func addShadow(shadowColor: CGColor = UIColor.black.cgColor, shadowOffset: CGSize = .zero, shadowOpacity: Float = 0.2, shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
        layer.cornerRadius = 5
    }
}

