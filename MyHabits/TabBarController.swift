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

        UITabBar.appearance().barTintColor = UIColor(displayP3Red: 247, green: 247, blue: 247, alpha: 0.8)
        tabBar.tintColor = UIColor(named: "awesomePurple")
        delegate = self

        setupTabBar()
    }

    private func setupTabBar(){
        let habitTab = HabitViewController()
        habitTab.tabBarItem = UITabBarItem(title: self.title, image: UIImage(systemName: "rectangle.grid.1x2.fill"), tag: 0)
        let infoTab = InfoViewController()
        infoTab.tabBarItem = UITabBarItem(title: self.title, image: UIImage(systemName: "info.circle.fill"), tag: 1)
        let habitNavVC = UINavigationController(rootViewController: habitTab)
        let infoNavVC = UINavigationController(rootViewController: infoTab)
        self.viewControllers = [habitNavVC, infoNavVC]
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}


