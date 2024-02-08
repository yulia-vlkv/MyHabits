//
//  HabitsAssembly.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 08.02.2024.
//

import Foundation
import UIKit

class HabitsAssembly {
    static func makeModule() -> UIViewController {
        let view = HabitsViewController()
        let interactor = HabitsInteractor()
        let router = HabitsRouter()
        let presenter = HabitsPresenter(view: view, interactor: interactor, router: router)
        view.output = presenter
        return view
    }
}
