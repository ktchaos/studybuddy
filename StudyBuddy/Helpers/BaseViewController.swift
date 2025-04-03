//
//  BaseViewController.swift
//  StudyBuddy
//
//  Created by Catarina Serrano on 31/03/25.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    }
}
