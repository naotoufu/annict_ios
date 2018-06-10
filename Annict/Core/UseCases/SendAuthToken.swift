//
//  SendAuthToken.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/09.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
typealias SendAuthTokenUseCaseCompletionHandler = (_ authToken: Result<AuthToken>) -> Void

protocol SendAuthTokenUseCase {
    func sendAuthToken(code: String, completionHandler: @escaping SendAuthTokenUseCaseCompletionHandler)
}

class SendAuthTokenUseCaseImplementation: SendAuthTokenUseCase {
    let authTokenGateway: AuthTokenGateway
    
    init(authTokenGateway: AuthTokenGateway) {
        self.authTokenGateway = authTokenGateway
    }
    
    // MARK: - SendAuthTokenUseCase
    
    func sendAuthToken(code: String, completionHandler: @escaping (Result<AuthToken>) -> Void) {
        self.authTokenGateway.sendOauthToken(code: code) { (result) in
            // Do any additional processing & after that call the completion handler
            completionHandler(result)
        }
    }
}
