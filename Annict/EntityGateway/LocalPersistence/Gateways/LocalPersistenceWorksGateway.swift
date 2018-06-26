//
//  LocalPersistenceWorksGateway.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/23.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
import CoreData

protocol LocalPersistenceWorksGateway: WorksGateway {
    func save(works: [Work])
    
    func add(work: Work)
}

class CoreDataWorksGateway: LocalPersistenceWorksGateway {
    let viewContext: NSManagedObjectContextProtocol
    
    init(viewContext: NSManagedObjectContextProtocol) {
        self.viewContext = viewContext
    }
    
    // MARK: - WorksGateway
    
    func fetchWorks(completionHandler: @escaping (Result<[Work]>) -> Void) {
        if let coreDataWorks = try? viewContext.allEntities(withType: CoreDataWork.self) {
            let works = coreDataWorks.map { $0.work }
            completionHandler(.success(works))
        } else {
            completionHandler(.failure(CoreError(message: "Failed retrieving Works the data base")))
        }
    }
    
    func add(parameters: AddWorkParameters, completionHandler: @escaping (Result<Work>) -> Void) {
        guard let coreDataWork = viewContext.addEntity(withType: CoreDataWork.self) else {
            completionHandler(.failure(CoreError(message: "Failed adding the Work in the data base")))
            return
        }
        
        coreDataWork.populate(with: parameters)
        
        do {
            try viewContext.save()
            completionHandler(.success(coreDataWork.work))
        } catch {
            viewContext.delete(coreDataWork)
            completionHandler(.failure(CoreError(message: "Failed saving the context")))
        }
    }
    
    func delete(work: Work, completionHandler: @escaping (Result<Void>) -> Void) {
        let predicate = NSPredicate(format: "id==%@", work.id)
        
        if let coreDataWorks = try? viewContext.allEntities(withType: CoreDataWork.self, predicate: predicate),
            let coreDataWork = coreDataWorks.first {
            viewContext.delete(coreDataWork)
        } else {
            completionHandler(.failure(CoreError(message: "Failed retrieving Works the data base")))
            return
        }
        
        do {
            try viewContext.save()
            completionHandler(.success(()))
        } catch {
            completionHandler(.failure(CoreError(message: "Failed saving the context")))
        }
        
    }
    
    // MARK: - LocalPersistenceWorksGateway
    
    func save(works: [Work]) {
        // Save Works to core data. Depending on your specific need this might need to be turned into some kind of merge mechanism.
    }
    
    func add(work: Work) {
        // Add Work. Usually you could call this after the entity was successfully added on the API side or you could use the save method.
    }
}
