//
//  NavigationBar.swift
//  NavigationBarStyle
//
//  Created by Joshua Fisher on 1/4/16.
//  Copyright © 2016 Calendre Co. All rights reserved.
//

import UIKit

// MARK: Style

struct NavigationBarStyle {
    enum Background {
        case None
        case Transparent
        case BackgroundImage(UIImage?)
        case Color(UIColor?)
    }
    let background: Background
    let foregroundColor: UIColor?
    
    init(background: Background = .None, foregroundColor: UIColor? = nil) {
        self.background = background
        self.foregroundColor = foregroundColor
    }
}

// MARK: Context
// implemented by UIViewControllers so they can interop with the custom nav bar

protocol NavigationBarStyleContext: class {
    func prefersNavigationBarHidden() -> Bool
    func preferredNavigationBarStyle() -> NavigationBarStyle
}

extension NavigationBarStyleContext {
    func prefersNavigationBarHidden() -> Bool {
        return false
    }
}

// MARK: NavigationBar
// supports cleaner declarative styling
// allows touches to pass thru bar, if desirable

class NavigationBar: UINavigationBar {
    
    var capturesTouchesOnBackground: Bool = true
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        guard !capturesTouchesOnBackground else {
            return super.pointInside(point, withEvent: event)
        }
        
        let possibleSubviews = subviews.reverse().filter({ NSStringFromClass($0.dynamicType).localizedCaseInsensitiveContainsString("button") })
        for view in possibleSubviews {
            let pt = self.convertPoint(point, toView: view)
            if view.pointInside(pt, withEvent: event) {
                return true
            }
        }
        return false
    }
    
    func applyStyle(style: NavigationBarStyle) {
        switch style.background {
        case .None:
            setBackgroundImage(nil, forBarMetrics: .Default)
            shadowImage = nil
            barTintColor = nil
            capturesTouchesOnBackground = true

        case .Transparent:
            setBackgroundImage(UIImage(), forBarMetrics: .Default)
            shadowImage = UIImage()
            barTintColor = nil
            capturesTouchesOnBackground = false
            
        case .BackgroundImage(let image):
            setBackgroundImage(image, forBarMetrics: .Default)
            shadowImage = nil
            barTintColor = nil
            capturesTouchesOnBackground = true
            
        case .Color(let color):
            setBackgroundImage(nil, forBarMetrics: .Default)
            shadowImage = nil
            barTintColor = color
            capturesTouchesOnBackground = true
        }
        
        if let foregroundColor = style.foregroundColor {
            titleTextAttributes = [NSForegroundColorAttributeName: foregroundColor]
        } else {
            titleTextAttributes = nil
        }
        
        tintColor = style.foregroundColor
    }
}
