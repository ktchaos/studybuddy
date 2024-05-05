//
//  AppCell.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/06/23.
//

import UIKit

struct App {
    var icon: UIImage
    var applicationName: String
}

final class AppCell: UITableViewCell, Identifiable {
    // MARK: Properties

    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        return imageView
    }()
    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)//UIFont(name: "Courier New", size: 15)
        return label
    }()
    lazy var toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = false
        toggle.isEnabled = true
        return toggle
    }()
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [icon, appNameLabel, toggle])
        stack.axis = .horizontal
        stack.spacing = 16
        return stack
    }()

    // MARK: Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: "RoutineCell")

        setupSubviews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        toggle.setOn(selected, animated: true)
    }

    // MARK: Setup

    func setupSubviews() {
        addSubview(hStack)
        selectionStyle = .none
    }

    func setupConstraints() {
        icon.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.height.equalTo(32)
        }
        hStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.trailing.equalToSuperview().inset(6)
            $0.leading.equalToSuperview().inset(6)
        }
    }

    func setupCell(with app: App) {
        self.addShadow()
        appNameLabel.text = app.applicationName
        icon.image = app.icon
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

