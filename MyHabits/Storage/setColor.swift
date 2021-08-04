//
//  setColor.swift
//  MyHabits
//
//  Created by Iuliia Volkova on 27.07.2021.
//

import UIKit

func setStatusBarColor(color: UIColor){
    let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
    let statusBarColor = color
    statusBarView.backgroundColor = statusBarColor
    view.addSubview(statusBarView)
}
