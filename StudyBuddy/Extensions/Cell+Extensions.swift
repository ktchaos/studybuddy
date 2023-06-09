//
//  Cell+Extensions.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 08/06/23.
//

import Foundation
import UIKit

protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable {
    static var identifier: String {
        String(describing: self)
    }
}
