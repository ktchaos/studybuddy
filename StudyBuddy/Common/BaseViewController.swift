import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Force light mode
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    }
}