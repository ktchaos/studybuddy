//
//  PomodoroAndSoundViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 06/05/24.
//

import AVFoundation
import UIKit
import SnapKit

protocol PomodoroAndSoundViewControlling {
    func updatePomodoroLabel(with time: String)
    func updateBreakLabel(with time: String)
    func enableBreakLabel()
    func enablePomodoroLabel()
}

final class PomodoroAndSoundViewController: BaseViewController, PomodoroAndSoundViewControlling {
    // MARK: Pomodoro UI

    private lazy var breakTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Intervalo"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.isEnabled = false
        return label
    }()

    private lazy var breakTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "10:00"
        label.font = UIFont.systemFont(ofSize: 28)
        label.isEnabled = false
        return label
    }()

    private lazy var breakTimeStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [breakTimeTitleLabel, breakTimeLabel])
        stack.axis = .vertical
        return stack
    }()

    private lazy var mainTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sessão"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.isEnabled = false
        return label
    }()

    private lazy var mainTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:50:00"
        label.font = UIFont.systemFont(ofSize: 52)
        return label
    }()

    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [mainTimeTitleLabel, mainTimeLabel])
        stack.axis = .vertical
        return stack
    }()

    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("   Iniciar   ", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.systemGreen.cgColor
        button.addTarget(self, action: #selector(self.didTapStartButton), for: .touchUpInside)
        return button
    }()

    private lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("   Pausar   ", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.addTarget(self, action: #selector(self.didTapResetButton), for: .touchUpInside)
        return button
    }()

    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [startButton, resetButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 24
        return stack
    }()

    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        return view
    }()

    // MARK: Player UI

    private lazy var audioLabel: UILabel = {
        let label = UILabel()
        label.text = "Áudio: "
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        return label
    }()

    private lazy var playPauseButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.tintColor = .black
        button.setBackgroundImage(playImage, for: .normal)
        button.addTarget(self, action: #selector(self.didTapPlayPauseButton), for: .touchUpInside)
        return button
    }()

    private lazy var finishRoutineButton: UIButton = {
        let button = UIButton()
        button.setTitle("   Encerrar rotina   ", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
        button.layer.borderColor = UIColor.red.cgColor
        button.backgroundColor = .systemRed
        button.alpha = 0.5
        button.addTarget(self, action: #selector(self.didTapFinishRoutineButton), for: .touchUpInside)
        return button
    }()

    private let playImage = UIImage(systemName: "play.circle.fill")
    private let pauseImage = UIImage(systemName: "pause.circle.fill")
    var audioButtonState: AudioButtonState = .idle
    var interactor: PomodoroAndSoundInteracting?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
        interactor = nil
    }

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
        view.addSubview(breakTimeStackView)
        view.addSubview(mainStackView)
        view.addSubview(buttonsStackView)
        view.addSubview(lineView)
        view.addSubview(audioLabel)
        view.addSubview(playPauseButton)
        view.addSubview(finishRoutineButton)

        breakTimeStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(142)
            $0.centerX.equalToSuperview()
        }

        mainStackView.snp.makeConstraints {
            $0.top.equalTo(breakTimeLabel.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }

        buttonsStackView.snp.makeConstraints {
            $0.top.equalTo(mainStackView.snp.bottom).offset(64)
            $0.centerX.equalToSuperview()
        }

        lineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(buttonsStackView.snp.bottom).offset(32)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        audioLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(64)
            $0.centerX.equalToSuperview()
        }

        playPauseButton.snp.makeConstraints {
            $0.top.equalTo(audioLabel.snp.bottom).offset(34)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(54)
        }

        finishRoutineButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(62)
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalToSuperview().inset(32)
        }
    }
}

extension PomodoroAndSoundViewController {
    @objc func didTapPlayPauseButton() {
        switch audioButtonState {
        case .idle:
            audioButtonState = .playing
            interactor?.startPlayingAudio()
            playPauseButton.setBackgroundImage(pauseImage, for: .normal)
        case .paused:
            // se tá PAUSED, e ele clicou, troca para a imagem para pause
            // muda o estado para
            playPauseButton.setBackgroundImage(pauseImage, for: .normal)
            audioButtonState = .playing
            interactor?.startPlayingAudio()
        case .playing:
            // se tá PLAYING, e ele clicou, troca para a imagem para play
            // muda o estado para PAUSED
            playPauseButton.setBackgroundImage(playImage, for: .normal)
            audioButtonState = .paused
            interactor?.stopPlayingAudio()
        }
    }

    @objc func didTapFinishRoutineButton() {
        interactor?.didTapFinishRoutine()
    }

    @objc func didTapStartButton() {
        interactor?.didTapStartPomodoro()
    }

    @objc func didTapResetButton() {
        interactor?.didTapResetPomodoro()
    }
}

extension PomodoroAndSoundViewController {
    func updatePomodoroLabel(with time: String) {
        mainTimeLabel.text = time
    }

    func updateBreakLabel(with time: String) {
        breakTimeLabel.text = time
    }

    func enableBreakLabel() {
        breakTimeLabel.isEnabled = true
        mainTimeLabel.isEnabled = false
    }

    func enablePomodoroLabel() {
        mainTimeLabel.isEnabled = true
        breakTimeLabel.isEnabled = false
    }
}
