//
//  AuthTokenGateWay.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/09.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation

typealias SendOauthTokenEntityGatewayCompletionHandler = (_ authToken: Result<AuthToken>) -> Void

protocol AuthTokenGateway {
    func sendOauthToken(code: String, completionHandler: @escaping SendOauthTokenEntityGatewayCompletionHandler)
}
