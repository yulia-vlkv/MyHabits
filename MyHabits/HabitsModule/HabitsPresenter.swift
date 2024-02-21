//
//  HabitsViewPresenter.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 28.01.2024.
//

import UIKit


protocol HabitsModuleInput: HabitsInteractorOutput, HabitsViewOutput {
    func createNewHabit()
    func reloadIfNeeded()
}

final class HabitsPresenter: HabitsModuleInput {
    
    var router: HabitsRouterInput!
    var interactor: HabitsInteractorInput!
    var view: HabitsViewInput!
    
    init(view: HabitsViewInput, interactor: HabitsInteractorInput, router: HabitsRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view.setupInitialState()
        view.setupCollectionView()
    }
    
    func habitSaved() {
        interactor.save()
    }
    
    func createNewHabit() {
        router.openCreateHabit()
    }
    
    func cellForItem(_ collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            let progressCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell
            progressCell.updateProgress()
            return progressCell
        default:
            let habitCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
            habitCell.habit = interactor.getHabit(with: indexPath.item)
            habitCell.isChecked = { self.view.reloadData() }
            return habitCell
        }
    }
    
    func numberOfItemsInSection(at section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return interactor.getHabitsCount()
        }
    }
    
    func didSelectItemAt(at indexPath: IndexPath) {
        switch indexPath.section {
        case 1: router.openDetail(with: interactor.getHabit(with: indexPath.row))
        default: break
        }
    }
    
    func reloadIfNeeded(){
        view.reloadData()
    }
    
}
