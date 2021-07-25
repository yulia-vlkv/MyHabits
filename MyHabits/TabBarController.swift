//
//  TabBarController.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 25.07.2021.
//

class HabitsTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let habitTab = HabitViewController()
        habitTab.tabBarItem = UITabBarItem(title: self.title, image: UIImage(systemName: "rectangle.grid.1x2.fill"), selectedImage: UIImage(systemName: "rectangle.grid.1x2.fill"))
        let infoTab = InfoViewController()
        infoTab.tabBarItem = UITabBarItem(title: self.title, image: UIImage(systemName: "info.circle.fill"), selectedImage: UIImage(systemName: "info.circle.fill"))
        self.viewControllers = [habitTab, infoTab]
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
