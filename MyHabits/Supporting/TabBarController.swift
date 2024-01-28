//
//  TabBarController.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 25.07.2021.
//

import  UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().barTintColor = SelectedColors.setColor(style: .navBarWhite)
        tabBar.tintColor = SelectedColors.setColor(style: .purple)
        delegate = self

        setupTabBar()
    }

    private func setupTabBar(){
        let habitTab = HabitsViewController()
        habitTab.tabBarItem = UITabBarItem(title: "Привычки", image: UIImage(systemName: "rectangle.grid.1x2.fill"), tag: 0)
        let infoTab = InfoViewController()
        infoTab.tabBarItem = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle.fill"), tag: 1)
        let habitNavVC = UINavigationController(rootViewController: habitTab)
        let infoNavVC = UINavigationController(rootViewController: infoTab)
        self.viewControllers = [habitNavVC, infoNavVC]
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}


