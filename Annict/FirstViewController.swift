//
//  FirstViewController.swift
//  Annict
//
//  Created by 伊東直人 on 2018/02/06.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBAction func loginButtonTapped(_ sender: Any) {
        if let vc = UIStoryboard(name: "Login", bundle: Bundle.main).instantiateInitialViewController() as? LoginViewController{
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

