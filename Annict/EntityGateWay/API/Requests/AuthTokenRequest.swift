//
//  AuthTokenRequest.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/08.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation

struct  AuthTokenRequest: ApiRequest {
    var code: String!
    
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: AnnictConsts.rootURI + "/oauth/token")
        urlComponents?.queryItems = [URLQueryItem(name: "client_id", value: AnnictConsts.clientID),
                                     URLQueryItem(name: "client_secret", value: AnnictConsts.clientSecret),
                                     URLQueryItem(name: "grant_type", value: "authorization_code"),
                                     URLQueryItem(name: "redirect_uri", value: AnnictConsts.redirectURI),
                                     URLQueryItem(name: "code", value: code)]
        
        var request = URLRequest(url: urlComponents!.url!)
        
        request.httpMethod = "POST"
        
        return request
    }
    
    init(code: String) {
        self.code = code
    }
}
