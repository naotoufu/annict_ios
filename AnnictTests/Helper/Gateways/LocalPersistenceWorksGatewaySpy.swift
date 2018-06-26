//
//  LocalPersistenceWorksGatewaySpy.swift
//  AnnictTests
//
//  Created by 伊東直人 on 2018/06/24.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation

@testable import Annict

class LocalPersistenceWorksGatewaySpy: LocalPersistenceWorksGateway {
    var fetchWorksResultToBeReturned: Result<[Work]>!
    var addWorkResultToBeReturned: Result<Work>!
    var deleteWorkResultToBeReturned: Result<Void>!
    
    var addWorkParameters: AddWorkParameters!
    var deletedWork: Work!
    var worksSaved: [Work]!
    var addedWork: Work!
    
    var fetchWorksCalled = false
    
    func fetchWorks(completionHandler: @escaping (Result<[Work]>) -> Void) {
        fetchWorksCalled = true
        completionHandler(fetchWorksResultToBeReturned)
    }
    
    func add(parameters: AddWorkParameters, completionHandler: @escaping (Result<Work>) -> Void) {
        addWorkParameters = parameters
        completionHandler(addWorkResultToBeReturned)
    }
    
    func delete(work: Work, completionHandler: @escaping (Result<Void>) -> Void) {
        deletedWork = work
        completionHandler(deleteWorkResultToBeReturned)
    }
    
    func save(works: [Work]) {
        worksSaved = works
    }
    
    func add(work: Work) {
        addedWork = work
    }
}
