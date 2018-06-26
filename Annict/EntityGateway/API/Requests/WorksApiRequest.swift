//
//  WorksApiRequest.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/23.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation

struct WorksApiRequest: ApiRequest {
    var urlRequest: URLRequest {
        let url: URL! = URL(string: "https://api.annict.com/v1/works")
        var request = URLRequest(url: url)
        
        request.setValue("Bearer fbd51e9bdf2120c6de2623a3de9884b6ccd3f4597af583062a8222f791d272bb", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        return request
    }
}
