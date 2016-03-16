//
//  AppDelegate.swift
//  NavigationBarStyle
//
//  Created by Joshua Fisher on 12/30/15.
//  Copyright © 2015 Calendre Co. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigator = Navigator()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let nav = navigator.navigationController
        nav.viewControllers = [FirstViewController()]
        nav.delegate = navigator
        
        window = UIWindow()
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }
}

class Navigator: NSObject, UINavigationControllerDelegate {
    
    private(set) lazy var navigationController = UINavigationController(navigationBarClass: NavigationBar.self, toolbarClass: nil)
    private lazy var navigationBar: NavigationBar = self.navigationController.navigationBar as! NavigationBar
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        viewController.extendedLayoutIncludesOpaqueBars = true
        viewController.automaticallyAdjustsScrollViewInsets = true
        
        guard let styleContext = viewController as? NavigationBarStyleContext else {
            return
        }
        
        let fadeTransition = CATransition()
        fadeTransition.type = kCATransitionFade
        fadeTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        fadeTransition.duration = 0.25
        navigationBar.layer.addAnimation(fadeTransition, forKey: nil)

        navigationController.setNavigationBarHidden(styleContext.prefersNavigationBarHidden(), animated: animated)
        navigationBar.applyStyle(styleContext.preferredNavigationBarStyle())
    }
}
