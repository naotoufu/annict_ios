//
//  ApiAuthTokenGateWay.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/09.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation

protocol ApiAuthTokenGateway: AuthTokenGateway {
    
}

class ApiAuthTokenGatewayImplementation: AuthTokenGateway {
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    // MARK: - ApiAuthTokenGateway
    
    func sendOauthToken(code: String,  completionHandler: @escaping (Result<AuthToken>) -> Void) {
        let authTokenRequest = AuthTokenRequest(code: code)
        apiClient.execute(request: authTokenRequest) { (result: Result<ApiResponse<ApiAuthToken>>) in
            switch result {
            case let .success(response):
                let authToken = response.entity.authToken
                completionHandler(.success(authToken))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
}
