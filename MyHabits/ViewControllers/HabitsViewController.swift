//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 25.07.2021.
//

import UIKit

class HabitsViewController: UIViewController {
    
    private let layout = UICollectionViewFlowLayout()
    private lazy var habitsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private let store = HabitsStore.shared
    private let appearance = UINavigationBarAppearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = SelectedColors.setColor(style: .almostWhite)
        
        setupAppearance()
        setupCollectionView()
        
        }
    
    // Настройки NavigationBar
    private func setupAppearance(){
        navigationItem.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = SelectedColors.setColor(style: .almostWhiteButForNavBar)
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addHabit))
        navigationController?.navigationBar.tintColor = SelectedColors.setColor(style: .awesomePurple)
    }
    
    @objc func addHabit(){
        let habitsCreateVC = EditHabitViewController ()
        let habitsCreateNavVC = UINavigationController(rootViewController: habitsCreateVC)
        habitsCreateNavVC.modalPresentationStyle = .fullScreen
        present(habitsCreateNavVC, animated: true)
    }
    
    private func setupCollectionView(){
        view.addSubview(habitsCollectionView)
        habitsCollectionView.toAutoLayout()
        habitsCollectionView.backgroundColor = SelectedColors.setColor(style: .almostWhite)
        
        habitsCollectionView.dataSource = self
        habitsCollectionView.delegate = self
        habitsCollectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitCollectionViewCell.self))
        habitsCollectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProgressCollectionViewCell.self))
        
        let constraints = [
            habitsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            habitsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            habitsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            habitsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        HabitsStore.shared.habits.sort(by: { $0.date < $1.date })
        habitsCollectionView.reloadData()
    }
}


extension HabitsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return store.habits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section{
        case 0:
            let progressCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell
            progressCell.updateProgress()
            return progressCell
        default:
            let habitCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
            habitCell.habit = store.habits[indexPath.item]
            habitCell.isChecked = { self.habitsCollectionView.reloadData() }
            return habitCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1: let vc = HabitDetailsViewController(habit: store.habits[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
        default: break
            
        }
    }

}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        switch indexPath.section {
        case 0:
            return CGSize(width: (habitsCollectionView.frame.width - 33), height: 60)
        default:
            return  CGSize(width: (habitsCollectionView.frame.width - 33), height: 130)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 22, left: .zero, bottom: .zero, right:.zero)
        default:
            return UIEdgeInsets(top: 18, left: .zero, bottom: .zero, right: .zero)
        }
    }
}
