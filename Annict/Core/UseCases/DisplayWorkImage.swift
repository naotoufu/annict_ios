//
//  DisplayWorkImage.swift
//  Annict
//
//  Created by 伊東直人 on 2018/07/11.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
typealias DisplayWorkImageUseCaseCompletionHandler = (_ workImage: Result<WorkImage>) -> Void

protocol DisplayWorkImageUseCase {
    func displayWorkImage(id: String, completionHandler: @escaping DisplayWorkImageUseCaseCompletionHandler)
}

class DisplayWorkImageUseCaseImplementation: DisplayWorkImageUseCase {
    
    let workImageGateway: WorkImageGateway
    
    init(workImageGateway: WorkImageGateway) {
        self.workImageGateway = workImageGateway
    }
    
    // MARK: - DisplayWorkImageUseCase
    
    func displayWorkImage(id: String, completionHandler: @escaping (Result<WorkImage>) -> Void) {
        self.workImageGateway.fetchWorkImage(id: id) { (result) in
            // Do any additional processing & after that call the completion handler
            completionHandler(result)
        }
    }
}
