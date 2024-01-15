//
//  extension.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 23/07/2021.
//

import UIKit
import AVKit
import Foundation


func Present(ViewController:UIViewController,ToViewController:UIViewController) {
    let Controller = ToViewController
    Controller.hidesBottomBarWhenPushed = true
    Controller.modalPresentationStyle = .fullScreen
    Controller.modalTransitionStyle = .coverVertical
    ViewController.navigationController?.pushViewController(Controller, animated: true)
}

func FirstController(_ Controller: UIViewController) {
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
    let transition: CATransition = CATransition()
    appDelegate.window?.rootViewController?.navigationController?.popViewController(animated: true)
    appDelegate.window?.makeKeyAndVisible()
    transition.duration = 0.5
    transition.type = CATransitionType.reveal
    transition.subtype = CATransitionSubtype.fromRight
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    appDelegate.window?.rootViewController?.view.window!.layer.add(transition, forKey: nil)
    let ControllerNav = UINavigationController(rootViewController: Controller)
    ControllerNav.navigationBar.isHidden = true
    appDelegate.window?.rootViewController = ControllerNav
    appDelegate.window?.rootViewController?.modalTransitionStyle = .flipHorizontal
    appDelegate.window?.rootViewController?.modalPresentationStyle = .fullScreen
    }
}

func topViewController(_ controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
if let navigationController = controller as? UINavigationController {
return topViewController(navigationController.visibleViewController)}
if let tabController = controller as? UITabBarController {
if let selected = tabController.selectedViewController {
return topViewController(selected)
}
}
if let presented = controller?.presentedViewController {
return topViewController(presented)
}
return controller
}


extension BidirectionalCollection {
    subscript(safe offset: Int) -> Element? {
        guard !isEmpty, let i = index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex)) else { return nil }
        return self[i]
    }
}


extension Sequence where Element: AdditiveArithmetic {
    func sum() -> Element { reduce(.zero, +) }
}


