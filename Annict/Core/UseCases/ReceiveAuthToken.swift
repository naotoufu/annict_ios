//
//  ReceiveAuthToken.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/09.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
typealias ReceiveAuthTokenUseCaseCompletionHandler = (_ authToken: Result<AuthToken>) -> Void

protocol ReceiveAuthTokenUseCase {
    func receiveAuthToken(code: String, completionHandler: @escaping ReceiveAuthTokenUseCaseCompletionHandler)
}

class ReceiveAuthTokenUseCaseImplementation: ReceiveAuthTokenUseCase {
    let authTokenGateway: AuthTokenGateway
    
    init(authTokenGateway: AuthTokenGateway) {
        self.authTokenGateway = authTokenGateway
    }
    
    // MARK: - ReceiveAuthTokenUseCase
    
    func receiveAuthToken(code: String, completionHandler: @escaping (Result<AuthToken>) -> Void) {
        self.authTokenGateway.receiveOauthToken(code: code) { (result) in
            // Do any additional processing & after that call the completion handler
            completionHandler(result)
        }
    }
}
