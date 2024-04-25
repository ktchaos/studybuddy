//
//  NewRoutineViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/06/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NewRoutineViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Título da rotina"
        label.numberOfLines = 0
        label.font = UIFont(name: "Courier New", size: 22)
        label.textColor = .black
        label.addGestureRecognizer(.init(target: self, action: #selector(self.onViewTouch)))
        return label
    }()

    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont(name: "Courier New", size: 18)
        textField.layer.borderWidth = 1
        textField.addPadding(.left(6))
        textField.delegate = self
        return textField
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Descreva um pouco sobre o que é essa rotina:"
        label.numberOfLines = 0
        label.font = UIFont(name: "Courier New", size: 15)
        label.textColor = .black
        return label
    }()

    private lazy var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont(name: "Courier New", size: 15)
        textField.layer.borderWidth = 1
        textField.addPadding(.left(6))
        textField.delegate = self
        return textField
    }()

    private lazy var selectTimeTitle: UILabel = {
        let label = UILabel()
        label.text = "Selecione a duração da rotina:"
        label.font = UIFont(name: "Courier New", size: 15)
        label.textColor = .black
        return label
    }()

    private lazy var timePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()

    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continuar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Courier New", size: 20)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(self.onNextTap), for: .touchUpInside)
        return button
    }()

    let minutes: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
    let hours: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "22", "23"]

    var pickerData: [[String]] = [[]]
    var routine: Routine?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        pickerData = [hours, minutes]

        setupUI()
        setupViews()
    }

    func setupUI() {
        title = "Nova rotina"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        view.addGestureRecognizer(.init(target: self, action: #selector(self.onViewTouch)))
    }

    func setupViews() {
        addShadow(view: titleTextField)
        addShadow(view: descriptionTextField)
        addShadow(view: timePickerView, shadowOpacity: 0.2)
        addShadow(view: nextButton)
        view.addSubview(titleTextField)
        view.addSubview(titleLabel)
        view.addSubview(descriptionTextField)
        view.addSubview(descriptionLabel)
        view.addSubview(selectTimeTitle)
        view.addSubview(timePickerView)
        view.addSubview(nextButton)

        titleLabel.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(150)
        }

        titleTextField.snp.makeConstraints {
            $0.height.equalTo(64)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(titleLabel.snp.bottom)
        }

        descriptionLabel.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(titleTextField.snp.bottom).offset(16)
        }

        descriptionTextField.snp.makeConstraints {
            $0.height.equalTo(64)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(descriptionLabel.snp.bottom)
        }

        selectTimeTitle.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(descriptionTextField.snp.bottom).offset(12)
        }

        timePickerView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(selectTimeTitle.snp.bottom)
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
        let selectPomodoroViewController = SelectPomodoroViewController()
        self.navigationController?.pushViewController(selectPomodoroViewController, animated: true)
    }
}

extension NewRoutineViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24
        case 1:
            return 1
        case 2:
            return 60
        case 3:
            return 1
        default:
            return 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0, 2:
            return "\(row)"
        case 1:
            return "horas"
        case 3:
            return "minutos"
        default:
            return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component {
        case 0:
            return 54
        case 1:
            return 100
        case 2:
            return 54
        case 3:
            return 100
        default:
            return 1
        }
    }
}

extension NewRoutineViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}

extension NewRoutineViewController {
    @objc func onViewTouch() {
        view.endEditing(true)
    }
}
