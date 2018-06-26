//
//  WorksViewRouter.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/24.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
import UIKit

protocol WorksViewRouter: ViewRouter {
    func presentDetailsView(for work: Work)
}

class WorksViewRouterImplementation: WorksViewRouter {
    fileprivate weak var worksTableViewController: WorksTableViewController?
    fileprivate var work: Work!
    
    init(worksTableViewController: WorksTableViewController) {
        self.worksTableViewController = worksTableViewController
    }
    
    // MARK: - WorksViewRouter
    
    func presentDetailsView(for work: Work) {
        self.work = work
        worksTableViewController?.performSegue(withIdentifier: "WorksSceneToWorkDetailsSceneSegue", sender: nil)
    }

}
