//
//  Fonts.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 04.08.2021.
//

import UIKit

enum SelectedFonts {
    case title
    case headline
    case body
    case footnoteBold
    case footnoteRegular
    case caption
    
    static func setFont (style: SelectedFonts) -> UIFont {
        switch style {
        case .title:
            return UIFont.systemFont(ofSize: 20, weight: .semibold)
        case .headline:
            return UIFont.systemFont(ofSize: 17, weight: .semibold)
        case .body:
            return UIFont.systemFont(ofSize: 17, weight: .regular)
        case .footnoteBold:
            return UIFont.systemFont(ofSize: 13, weight: .semibold)
        case .footnoteRegular:
            return UIFont.systemFont(ofSize: 13, weight: .regular)
        case .caption:
            return UIFont.systemFont(ofSize: 12, weight: .regular)
        }
    }
}
