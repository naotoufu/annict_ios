//
//  DeleteWorkApiRequest.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/23.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
// Dummy implementation. The endpoint doesn't exist.
struct DeleteWorkApiRequest: ApiRequest {
    let workId: Int
    
    var urlRequest: URLRequest {
        let url: URL! = URL(string: "https://api.library.fortech.ro/Works/\(workId)")
        var request = URLRequest(url: url)
        
        request.httpMethod = "DELETE"
        
        return request
    }
}
