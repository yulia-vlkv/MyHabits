//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 25.07.2021.
//

import UIKit

protocol HabitsViewInput: AnyObject {
    func setupInitialState()
    func setupCollectionView()
    func reloadData()
}

protocol HabitsViewOutput {
    func viewDidLoad()
    func cellForItem(_ collectionView: UICollectionView, at: IndexPath) -> UICollectionViewCell
    func numberOfItemsInSection(at: Int) -> Int
    func didSelectItemAt(at: IndexPath)
}

class HabitsViewController: UIViewController, HabitsViewInput {
    
    var output: HabitsViewOutput!
    var router: HabitsRouterInput!
    var interactor: HabitsInteractorInput!
        
    private let layout = UICollectionViewFlowLayout()
    lazy var habitsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private let appearance = UINavigationBarAppearance()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        output = HabitsPresenter(view: self, interactor: interactor, router: router)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    func reloadData(){
        habitsCollectionView.reloadData()
    }
    
    func setupInitialState(){
        view.backgroundColor = SelectedColors.setColor(style: .white)
        navigationItem.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = SelectedColors.setColor(style: .navBarWhite)
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addHabit))
        navigationController?.navigationBar.tintColor = SelectedColors.setColor(style: .purple)
    }
    
    @objc func addHabit(){
        HabitsPresenter(view: self, interactor: interactor, router: router).createNewHabit()
    }
    
    func setupCollectionView(){
        view.addSubview(habitsCollectionView)
        habitsCollectionView.toAutoLayout()
        habitsCollectionView.backgroundColor = SelectedColors.setColor(style: .white)
        
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
        
        EditHabitInteractor.shared.habits.sort(by: { $0.date < $1.date })
        habitsCollectionView.reloadData()
    }
}

// MARK: - DataSource
extension HabitsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        output?.numberOfItemsInSection(at: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        output?.cellForItem(collectionView, at: indexPath) ?? collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! HabitCollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output?.didSelectItemAt(at: indexPath)
    }

}

// MARK: - FlowLayout
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
