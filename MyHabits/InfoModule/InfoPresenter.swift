//
//  InfoPresenter.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 07.02.2024.
//

import Foundation


protocol InfoModuleInput: InfoViewOutput {
    func viewDidLoad()
}

protocol InfoModuleOutput {

}

final class InfoPresenter: InfoModuleInput, InfoModuleOutput {
    
    var router: InfoRouterInput!
    weak var view: InfoViewInput!
    
    private let infoText = InfoText()
    
    init(view: InfoViewInput) {
        self.view = view
    }
    
    func viewDidLoad() {
        view.setupInitialState()
        view.setInfoTitle(with: infoText.infoTitle)
        view.setInfoText(with: infoText.infoText)
    }
    
}
