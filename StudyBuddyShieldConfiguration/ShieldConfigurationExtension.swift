//
//  ShieldConfigurationExtension.swift
//  StudyBuddyShieldConfiguration
//
//  Created by Catarina Serrano on 31/03/25.
//

import ManagedSettings
import ManagedSettingsUI
import UIKit

// Override the functions below to customize the shields used in various situations.
// The system provides a default appearance for any methods that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        // Customize the shield as needed for applications.
        ShieldConfiguration(
            backgroundColor: .lightGray,
            icon: UIImage(named: "sbclock"),
            title: ShieldConfiguration.Label(text: "Opa! O Study Buddy bloqueou esse aplicativo", color: .label),
            subtitle: ShieldConfiguration.Label(text: "Ele ficará disponível ao final da sua sessão.", color: .systemBrown),
            primaryButtonLabel: ShieldConfiguration.Label(text: "Fechar", color: .white),
            primaryButtonBackgroundColor: .black
        )
    }
    
    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for applications shielded because of their category.
        ShieldConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        // Customize the shield as needed for web domains.
        ShieldConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for web domains shielded because of their category.
        ShieldConfiguration()
    }
}
