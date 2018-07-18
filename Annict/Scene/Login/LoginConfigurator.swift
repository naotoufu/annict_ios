//
//  LoginConfigurator.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/10.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
protocol LoginConfigurator {
    func configure(loginViewController: LoginViewController)
}

class LoginConfiguratorImplementation: LoginConfigurator {
    
    func configure(loginViewController: LoginViewController) {
        let apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default,
                                                completionHandlerQueue: OperationQueue.main)
        let apiAuthTokenGateway = ApiAuthTokenGatewayImplementation(apiClient: apiClient)
        
        let authTokenGateway = CacheAuthTokenGateway(apiAuthTokenGateway: apiAuthTokenGateway)
        
        let receiveAuthTokenUseCase = ReceiveAuthTokenUseCaseImplementation(authTokenGateway: authTokenGateway)
        
        let presenter = LoginPresenterImplementation(receiveAuthTokenUseCase: receiveAuthTokenUseCase)
        
        loginViewController.presenter = presenter
    }
}
