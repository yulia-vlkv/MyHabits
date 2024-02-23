//
//  Colors.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 30.07.2021.
//

import UIKit

enum SelectedColors {
    case gray
    case lightGray
    case almostWhite
    case almostWhiteButForNavBar
    case awesomePurple
    case blue
    case green
    case indigo
    case orange
    
    static func setColor (style: SelectedColors) -> UIColor {
        switch style {
            case .gray:
                return UIColor.systemGray
            case .lightGray:
                return UIColor.systemGray2
            case .almostWhite:
                return UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
            case .almostWhiteButForNavBar:
                return UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
            case .awesomePurple:
                return UIColor(red: 151/255, green: 22/255, blue: 204/255, alpha: 1)
            case .blue:
                return UIColor(red: 41/255, green: 109/255, blue: 155/255, alpha: 1)
            case .green:
                return UIColor(red: 29/255, green: 179/255, blue: 34/255, alpha: 1)
            case .indigo:
                return UIColor(red: 98/255, green: 54/255, blue: 255/255, alpha: 1)
            case .orange:
                return UIColor(red: 255/255, green: 159/255, blue: 79/255, alpha: 1)
        }
    }
}


