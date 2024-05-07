//
//  RoutineCell.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/06/23.
//

import Foundation
import UIKit

final class RoutineCell: UITableViewCell, Identifiable {
    private lazy var nameOfTheRoutineLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
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
        hStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.trailing.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
    }

    func setupCell(with title: String, _ duration: String) {
        self.addShadow()
        nameOfTheRoutineLabel.text = title
        durationLabel.text = duration
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

