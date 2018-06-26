//
//  WorksConfigurator.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/24.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
protocol WorksConfigurator {
    func configure(worksTableViewController: WorksTableViewController)
}

class WorksConfiguratorImplementation: WorksConfigurator {
    
    func configure(worksTableViewController: WorksTableViewController) {
        let apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default,
                                                completionHandlerQueue: OperationQueue.main)
        let apiWorksGateway = ApiWorksGatewayImplementation(apiClient: apiClient)
        let viewContext = CoreDataStackImplementation.sharedInstance.persistentContainer.viewContext
        let coreDataWorksGateway = CoreDataWorksGateway(viewContext: viewContext)
        
        let worksGateway = CacheWorksGateway(apiWorksGateway: apiWorksGateway,
                                             localPersistenceWorksGateway: coreDataWorksGateway)
        
        let displayWorksUseCase = DisplayWorksListUseCaseImplementation(worksGateway: worksGateway)
        let deleteWorkUseCase = DeleteWorkUseCaseImplementation(worksGateway: worksGateway)
        let router = WorksViewRouterImplementation(worksTableViewController: worksTableViewController)
        
        let presenter = WorksPresenterImplementation(view: worksTableViewController,
                                                     displayWorksUseCase: displayWorksUseCase,
                                                     deleteWorkUseCase: deleteWorkUseCase,
                                                     router: router)
        
        worksTableViewController.presenter = presenter
    }
}
