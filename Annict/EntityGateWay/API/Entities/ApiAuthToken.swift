//
//  ApiAuthToken.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/09.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
struct ApiAuthToken: InitializableWithData, InitializableWithJson {
    var accessToken: String
    var tokenType: String
    var scope: String
    var createdAt: String
    
    init(data: Data?) throws {
        // Here you can parse the JSON or XML using the build in APIs or your favorite libraries
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data),
            let json = jsonObject as? [String: Any] else {
                throw NSError.createPraseError()
        }
        
        try self.init(json: json)
        
    }
    
    init(json: [String : Any]) throws {
        guard let accessToken = json["access_token"] as? String,
            let tokenType = json["token_type"] as? String,
            let scope = json["scope"] as? String,
            let createdAt = json["created_at"] as? String else {
                throw NSError.createPraseError()
        }
        
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.scope = scope
        self.createdAt = createdAt
    }
}

extension ApiAuthToken {
    var authToken: AuthToken {
        return AuthToken(accessToken: accessToken, tokenType: tokenType, scope: scope, createdAt: createdAt)
    }
}
