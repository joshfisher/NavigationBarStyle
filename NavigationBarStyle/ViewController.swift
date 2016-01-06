//
//  ViewController.swift
//  NavigationBarStyle
//
//  Created by Joshua Fisher on 12/30/15.
//  Copyright © 2015 Calendre Co. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var buttonAction: (() -> Void)!
    
    func installButtonWithTitle(title: String, action: () -> Void) {
        let button = UIButton()
        button.addTarget(self, action: "buttonPressed", forControlEvents: .TouchUpInside)
        button.setTitle(title, forState: .Normal)
        button.sizeToFit()
        button.center = view.center
        view.addSubview(button)
        
        buttonAction = action
    }
    
    @objc private func buttonPressed() {
        buttonAction()
    }
}

// MARK: 1

class FirstViewController: ViewController {
    override func viewDidLoad() {
        view.backgroundColor = UIColor.blackColor()
        installButtonWithTitle("-> second") {
            let second = SecondViewController()
            self.navigationController?.pushViewController(second, animated: true)
        }
    }
}

extension FirstViewController: NavigationBarStyleContext {
    func preferredNavigationBarStyle() -> NavigationBarStyle {
        return NavigationBarStyle(background: .BackgroundImage(UIImage(named:"battle_of_kittens")), foregroundColor: UIColor.blackColor())
    }
}

// MARK: 2

class SecondViewController: ViewController {
    override func viewDidLoad() {
        view.backgroundColor = UIColor.blackColor()
        installButtonWithTitle("-> third") {
            let third = ThirdViewController()
            self.navigationController?.pushViewController(third, animated: true)
        }
    }
}

extension SecondViewController: NavigationBarStyleContext {
    func preferredNavigationBarStyle() -> NavigationBarStyle {
        return NavigationBarStyle(background: .Transparent, foregroundColor: UIColor.whiteColor())
    }
}

// MARK: 3

class ThirdViewController: ViewController {
    override func viewDidLoad() {
        view.backgroundColor = UIColor.blackColor()
        installButtonWithTitle("-> fourth") {
            let fourth = FourthViewController()
            self.navigationController?.pushViewController(fourth, animated: true)
        }
    }
}

extension ThirdViewController: NavigationBarStyleContext {
    func preferredNavigationBarStyle() -> NavigationBarStyle {
        return NavigationBarStyle(background: .None, foregroundColor: UIColor.blackColor())
    }
}

// MARK: 4

class FourthViewController: ViewController {
    override func viewDidLoad() {
        view.backgroundColor = UIColor.blackColor()
    }
}

extension FourthViewController: NavigationBarStyleContext {
    func preferredNavigationBarStyle() -> NavigationBarStyle {
        return NavigationBarStyle(background: .Color(UIColor.blueColor()), foregroundColor: UIColor.redColor())
    }
}
