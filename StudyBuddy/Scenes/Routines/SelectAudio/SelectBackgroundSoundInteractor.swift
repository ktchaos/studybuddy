//
//  SelectBackgroundSoundInteractor.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 07/05/24.
//

import UIKit

protocol SelectBackgroundSoundInteracting {
    func getDataSourceCount() -> Int
    func getSoundConfig(for row: Int) -> SoundConfig
    func didSelectAudio(at row: Int)
    func didTapContinue()
    func didTapOnNotUsingSound()
}

final class SelectBackgroundSoundInteractor: SelectBackgroundSoundInteracting {
    private let presenter: SelectBackgroundSoundPresenting
    private var soundSelected: SoundConfig?
    private let dataSource = [
        SoundConfig(image: UIImage(systemName: "waveform") ?? UIImage(), name: "Frequências", path: "frequency"),
        SoundConfig(image: UIImage(systemName: "guitars.fill") ?? UIImage(), name: "Jazz", path: "jazz"),
        SoundConfig(image: UIImage(systemName: "slider.horizontal.below.square.filled.and.square") ?? UIImage(), name: "Lo-Fi", path: "lo-fi"),
        SoundConfig(image: UIImage(systemName: "tree.fill") ?? UIImage(), name: "Natureza", path: "nature")
    ]

    init(presenter: SelectBackgroundSoundPresenting) {
        self.presenter = presenter
    }
}

extension SelectBackgroundSoundInteractor {
    func getDataSourceCount() -> Int {
        return dataSource.count
    }

    func getSoundConfig(for row: Int) -> SoundConfig {
        return dataSource[row]
    }

    func didSelectAudio(at row: Int) {
        self.soundSelected = dataSource[row]
    }

    func didTapContinue() {
        guard let soundSelected = self.soundSelected else {
            return
        }

        presenter.goToBlockedAppsSelection(with: soundSelected.path, type: soundSelected.name)
    }

    func didTapOnNotUsingSound() {
        presenter.onTapNotUsingButton()
    }
}
