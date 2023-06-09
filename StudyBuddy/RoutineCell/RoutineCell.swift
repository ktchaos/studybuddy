//
//  RoutineCell.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/06/23.
//

import Foundation
import UIKit

struct Routine {
    var nameOfTheRoutine: String
    var rangeTime: String
}

final class RoutineCell: UITableViewCell, Identifiable {
    // MARK: Properties

    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        return imageView
    }()
    private lazy var helperView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [icon, helperView])
        stack.axis = .vertical
        stack.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stack.distribution = .fillProportionally
        return stack
    }()
    private lazy var nameOfTheRoutineLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont(name: "Courier New", size: 15)
        return label
    }()
    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont(name: "Courier New", size: 15)
        return label
    }()
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameOfTheRoutineLabel, durationLabel])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()

    var routine: Routine?

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

    // MARK: Setup

    func setupSubviews() {
        addSubview(hStack)
        selectionStyle = .none
    }

    func setupConstraints() {
//        icon.snp.makeConstraints {
//            $0.width.equalTo(42)
//            $0.height.equalTo(42)
//        }
        hStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.trailing.equalToSuperview().inset(6)
            $0.leading.equalToSuperview().inset(6)
        }
    }

    func setupCell(with routine: Routine) {
        self.addShadow()
        nameOfTheRoutineLabel.text = routine.nameOfTheRoutine
        durationLabel.text = routine.rangeTime
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

