//
//  Fonts.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 04.08.2021.
//

import UIKit

enum SelectedFonts {
    case Title
    case Headline
    case Body
    case FootnoteBold
    case FootnoteRegular
    case Caption
    
    static func setFont (style: SelectedFonts) -> UIFont {
        switch style {
        case .Title:
            return UIFont.systemFont(ofSize: 20, weight: .semibold)
        case .Headline:
            return UIFont.systemFont(ofSize: 17, weight: .semibold)
        case .Body:
            return UIFont.systemFont(ofSize: 17, weight: .regular)
        case .FootnoteBold:
            return UIFont.systemFont(ofSize: 13, weight: .semibold)
        case .FootnoteRegular:
            return UIFont.systemFont(ofSize: 13, weight: .regular)
        case .Caption:
            return UIFont.systemFont(ofSize: 12, weight: .regular)
        }
    }
}
