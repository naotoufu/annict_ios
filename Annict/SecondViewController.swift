//
//  SecondViewController.swift
//  Annict
//
//  Created by 伊東直人 on 2018/02/06.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBAction func onRequestWorkButtontapped(_ sender: Any) {
        let apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default,
                                                completionHandlerQueue: OperationQueue.main)
        let apiWorksGateway = ApiWorksGatewayImplementation(apiClient: apiClient)
        let viewContext = CoreDataStackImplementation.sharedInstance.persistentContainer.viewContext
        let coreDataWorksGateway = CoreDataWorksGateway(viewContext: viewContext)
        
        let worksGateway = CacheWorksGateway(apiWorksGateway: apiWorksGateway,
                                             localPersistenceWorksGateway: coreDataWorksGateway)
        worksGateway.fetchWorks { (result) in
            switch result {
            case .success(let works):
                print(works)
            case .failure(let error):
                print(error)
            }
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

