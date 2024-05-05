//
//  TabBarScene.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 23/04/24.
//

import Foundation

protocol TabBarScene {
    var coordinator: NavigationCoordinator { get }
    var title: String { get }
    var iconNameOff: String { get }
    var iconNameOn: String { get }
}
