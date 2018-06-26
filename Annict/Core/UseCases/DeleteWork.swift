//
//  DeleteWork.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/23.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation

typealias DeleteWorkUseCaseCompletionHandler = (_ works: Result<Void>) -> Void

struct DeleteWorkUseCaseNotifications {
    // Notification sent when a Work is deleted having the Work set to the notification object
    static let didDeleteWork = Notification.Name("didDeleteWorkNotification")
}

protocol DeleteWorkUseCase {
    
    func delete(work: Work, completionHandler: @escaping DeleteWorkUseCaseCompletionHandler)
}

class DeleteWorkUseCaseImplementation: DeleteWorkUseCase {
    
    let worksGateway: WorksGateway
    
    init(worksGateway: WorksGateway) {
        self.worksGateway = worksGateway
    }
    
    // MARK: - DeleteWorkUseCase
    
    func delete(work: Work, completionHandler: @escaping (Result<Void>) -> Void) {
        self.worksGateway.delete(work: work) { (result) in
            // Do any additional processing & after that call the completion handler
            // In this case we will broadcast a notification
            switch result {
            case .success():
                NotificationCenter.default.post(name: DeleteWorkUseCaseNotifications.didDeleteWork, object: work)
                completionHandler(result)
            case .failure(_):
                completionHandler(result)
            }
        }
    }
    
}
