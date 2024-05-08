//
//  RankingPresenter.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/05/24.
//

protocol RankingPresenting {
    var viewController: RankingViewControlling? { get set }
}

final class RankingPresenter: RankingPresenting {
    var viewController: RankingViewControlling?

}
