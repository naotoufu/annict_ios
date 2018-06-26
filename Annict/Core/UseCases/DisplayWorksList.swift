//
//  DisplayWorksList.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/23.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
typealias DisplayWorksUseCaseCompletionHandler = (_ works: Result<[Work]>) -> Void

protocol DisplayWorksUseCase {
    func displayWorks(completionHandler: @escaping DisplayWorksUseCaseCompletionHandler)
}

class DisplayWorksListUseCaseImplementation: DisplayWorksUseCase {
    let worksGateway: WorksGateway
    
    init(worksGateway: WorksGateway) {
        self.worksGateway = worksGateway
    }
    
    // MARK: - DisplayWorksUseCase
    
    func displayWorks(completionHandler: @escaping (Result<[Work]>) -> Void) {
        self.worksGateway.fetchWorks { (result) in
            // Do any additional processing & after that call the completion handler
            completionHandler(result)
        }
    }
}
