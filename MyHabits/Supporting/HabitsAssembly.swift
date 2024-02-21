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
        router.viewController = view
        let presenter = HabitsPresenter(view: view, interactor: interactor, router: router)
        view.output = presenter
        return view
    }
}

//Далее следует пример о создания класса Assembly с дженериками
//protocol View: AnyObject {
//    var output: Presenter? { get set }
//    
//    init()
//}
//
//protocol Interactor: AnyObject {
//    init()
//}
//
//protocol Router: AnyObject {
//    init()
//}
//
//protocol Presenter: AnyObject {
//    var view: View { get }
//    var router: Router { get set }
//    var interactor: Interactor { get set }
//    
//    init(view: View, interactor: Interactor, router: Router)   
//}
//
//class MyPresenter: Presenter {
//    private(set) var view: View
//    var router: Router
//    var interactor: Interactor
//
//    required init(view: View, interactor: Interactor, router: Router) {
//        self.view = view
//    }
//
//}

//class Assembly<P: Presenter, I: Interactor, V: View, R: Router> {
//
//    static func makeModule() -> V {
//        let view = V()
//        let interactor = I()
//        let router = R()
//        let presenter = P(view: view, interactor: interactor, router: router)
//        view.output = presenter
//        return view
//    }
//}

//class MyAssembly: Assembly<HabitsPresenter, HabitsInteractor, HabitsViewController, HabitsRouter> {
//}
