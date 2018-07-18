//
//  CacheAuthToken.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/09.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
class CacheAuthTokenGateway: AuthTokenGateway {
    
    let apiAuthTokenGateway: ApiAuthTokenGateway
    
    init(apiAuthTokenGateway: ApiAuthTokenGateway) {
        self.apiAuthTokenGateway = apiAuthTokenGateway
    }
    
    // MARK: - AuthTokenGateway
    
    func receiveOauthToken(code: String, completionHandler: @escaping (Result<AuthToken>) -> Void) {
        apiAuthTokenGateway.receiveOauthToken(code: code) { (result) in
            self.handleFetchAuthTokensApiResult(result, completionHandler: completionHandler)
        }
    }
    
    // MARK: - Private
    
    fileprivate func handleFetchAuthTokensApiResult(_ result: Result<AuthToken>, completionHandler: @escaping (Result<AuthToken>) -> Void) {
        switch result {
        case let .success(authTokens):
            print(authTokens)
            completionHandler(result)
        case let .failure(error):
            print(error)
        }
    }
}
