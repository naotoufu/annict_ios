//
//  CacheWorksGateway.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/23.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
// Discussion:
// Maybe it makes sense to perform all the operations locally and only after that make the API call
// to sync the local content with the API.
// If that's the case you will only have to change this class and the use case won't be impacted
class CacheWorksGateway: WorksGateway {
    let apiWorksGateway: ApiWorksGateway
    let localPersistenceWorksGateway: LocalPersistenceWorksGateway
    
    init(apiWorksGateway: ApiWorksGateway, localPersistenceWorksGateway: LocalPersistenceWorksGateway) {
        self.apiWorksGateway = apiWorksGateway
        self.localPersistenceWorksGateway = localPersistenceWorksGateway
    }
    
    // MARK: - WorksGateway
    
    func fetchWorks(completionHandler: @escaping (Result<[Work]>) -> Void) {
        apiWorksGateway.fetchWorks { (result) in
            self.handleFetchWorksApiResult(result, completionHandler: completionHandler)
        }
    }
    
    func add(parameters: AddWorkParameters, completionHandler: @escaping (Result<Work>) -> Void) {
        apiWorksGateway.add(parameters: parameters) { (result) in
            self.handleAddWorkApiResult(result, parameters: parameters, completionHandler: completionHandler)
        }
    }
    
    func delete(work: Work, completionHandler: @escaping (Result<Void>) -> Void) {
        apiWorksGateway.delete(work: work) { (result) in
            self.localPersistenceWorksGateway.delete(work: work, completionHandler: completionHandler)
        }
    }
    
    // MARK: - Private
    
    fileprivate func handleFetchWorksApiResult(_ result: Result<[Work]>, completionHandler: @escaping (Result<[Work]>) -> Void) {
        switch result {
        case let .success(works):
            localPersistenceWorksGateway.save(works: works)
            completionHandler(result)
        case .failure(_):
            localPersistenceWorksGateway.fetchWorks(completionHandler: completionHandler)
        }
    }
    
    fileprivate func handleAddWorkApiResult(_ result: Result<Work>, parameters: AddWorkParameters, completionHandler: @escaping (Result<Work>) -> Void) {
        switch result {
        case let .success(work):
            self.localPersistenceWorksGateway.add(work: work)
            completionHandler(result)
        case .failure(_):
            self.localPersistenceWorksGateway.add(parameters: parameters, completionHandler: completionHandler)
        }
    }
    
}
