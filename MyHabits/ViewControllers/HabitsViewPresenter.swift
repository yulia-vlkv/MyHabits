//
//  HabitsViewPresenter.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 28.01.2024.
//

import UIKit

protocol Presenter {
    
    func viewDidLoad()
    func cellForItem(at: IndexPath) -> UICollectionViewCell
    func numberOfItemsInSection(at: Int) -> Int
    func didSelectItemAt(at: IndexPath)
}


final class HabitsViewPresenter: Presenter {
     
    let store = HabitsStore.shared
    private let viewController: HabitsViewController
    
    private var view: UIView {
        viewController.view
    }
    
    private var collectionView: UICollectionView {
        viewController.habitsCollectionView
    }
    
    init(viewController: HabitsViewController) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        view.backgroundColor = SelectedColors.setColor(style: .white)
        
        viewController.setupAppearance()
        viewController.setupCollectionView()
    }
    
    func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            let progressCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell
            progressCell.updateProgress()
            return progressCell
        default:
            let habitCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
            habitCell.habit = store.habits[indexPath.item]
            habitCell.isChecked = { self.collectionView.reloadData() }
            return habitCell
        }
    }
    
    func numberOfItemsInSection(at section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return store.habits.count
        }
    }
    
    func didSelectItemAt(at indexPath: IndexPath) {
        switch indexPath.section {
        case 1: let vc = HabitDetailsViewController(habit: store.habits[indexPath.row])
            viewController.navigationController?.pushViewController(vc, animated: true)
        default: break
        }
    }
}
