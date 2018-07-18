//
//  WorkImageGateway.swift
//  Annict
//
//  Created by 伊東直人 on 2018/07/11.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation

typealias FetchWorkImageEntityGatewayCompletionHandler = (_ workImage: Result<WorkImage>) -> Void

protocol WorkImageGateway {
    func fetchWorkImage(id: String, completionHandler: @escaping FetchWorkImageEntityGatewayCompletionHandler)
}
