//
//  AppTheme.swift
//  techSocialMediaApp
//
//  Created by Tyler May on 2/2/24.
//

import Foundation
import UIKit

struct AppTheme {
    static let primaryColor = UIColor(red: 80/255, green: 74/255, blue: 255/255, alpha: 1.0)
    static let secondaryColor = UIColor(red: 107/255, green: 106/255, blue: 153/255, alpha: 1.0)
    static let textColor = UIColor.white
    static let buttonColor = UIColor(red: 91/255, green: 91/255, blue: 102/255, alpha: 1.0)

    static func setPrimaryBackgroundColor(for view: UIView) {
        view.backgroundColor = primaryColor
    }
}
