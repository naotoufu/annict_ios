//
//  AuthorizationRequest.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/08.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
struct AuthorizationRequest: ApiRequest {
    
    var urlRequest: URLRequest {
        
        var request = URLRequest(url: AnnictConsts.oauthURL()!)

        request.httpMethod = "GET"
        
        return request
    }
}
