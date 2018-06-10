//
//  UINavigationController.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/08.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var childViewControllerForStatusBarStyle: UIViewController? {
        return self.visibleViewController
    }

}
