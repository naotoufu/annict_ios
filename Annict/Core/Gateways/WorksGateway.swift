//
//  WorksGateway.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/23.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation

typealias FetchWorksEntityGatewayCompletionHandler = (_ works: Result<[Work]>) -> Void
typealias AddWorkEntityGatewayCompletionHandler = (_ works: Result<Work>) -> Void
typealias DeleteWorkEntityGatewayCompletionHandler = (_ works: Result<Void>) -> Void


protocol WorksGateway {
    func fetchWorks(completionHandler: @escaping FetchWorksEntityGatewayCompletionHandler)
    func add(parameters: AddWorkParameters, completionHandler: @escaping AddWorkEntityGatewayCompletionHandler)
    func delete(work: Work, completionHandler: @escaping DeleteWorkEntityGatewayCompletionHandler)
}
