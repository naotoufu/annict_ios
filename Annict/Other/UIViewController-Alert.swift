//
//  UIViewController-Alert.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/24.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentAlert(withTitle title:String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
}
