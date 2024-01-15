//
//  KRTabBar.swift
//  TabBarController
//
//  Created by Kerolles Roshdi on 2/14/20.
//  Copyright © 2020 Kerolles Roshdi. All rights reserved.
//

import UIKit

class TabBarController: BubbleTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    setupViewController()
    }
        
    fileprivate func setupViewController() {
    let Home = setupNavigationController(HomeVC(), "Home".localizable, "home", "home")

    let Categories = setupNavigationController(CategoriesVC(), "Categories".localizable, "Categories", "Categories")

    let Offers = setupNavigationController(OffersVC(), "Offers".localizable, "Offers", "OffersSelected")

    let Menu = setupNavigationController(MenuVC(), "Menu".localizable, "Menu", "Menu")
        
    tabBar.tintColor = #colorLiteral(red: 0.9604254365, green: 0.7348319888, blue: 0.001326194732, alpha: 1)
    tabBar.shadowImage = UIImage()
    tabBar.backgroundImage = UIImage()
    viewControllers = [Home,Categories,Offers,Menu]
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let fillColor = #colorLiteral(red: 0.9406575705, green: 0.9394521041, blue: 0.9605085994, alpha: 1).cgColor
        tabBar.roundCorners(corners: [.topLeft,.topRight], radius: ControlHeight(12), fillColor: fillColor)
    }

    fileprivate func setupNavigationController(_ viewController:UIViewController ,_ title:String ,_ Image:String ,_ SelectedImage:String) -> UINavigationController {
    let ControllerNav = UINavigationController(rootViewController: viewController)
    ControllerNav.navigationBar.isHidden = true
        
    viewController.tabBarItem.title = title
    viewController.tabBarItem.image = UIImage(named: Image)
    viewController.tabBarItem.selectedImage = UIImage(named: SelectedImage)
    return ControllerNav
    }
    
    }
