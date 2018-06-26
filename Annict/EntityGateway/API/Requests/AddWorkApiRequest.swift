//
//  AddWorkApiRequest.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/23.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
// Dummy implementation. The endpoint doesn't exist
struct AddWorkApiRequest: ApiRequest {
    let addWorkParameters: AddWorkParameters
    
    var urlRequest: URLRequest {
        let url: URL! = URL(string: "https://api.library.fortech.ro/Works")
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue("application/vnd.fortech.Work-creation+json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/vnd.fortech.Work+json", forHTTPHeaderField: "Accept")
        
        request.httpBody = addWorkParameters.toJsonData()
        
        return request
    }
}

// FIXME: API can't save works.
extension AddWorkParameters {
    func toJsonData() -> Data {
        var dictionary = [String: Any]()

//        dictionary["Work"] = work

        
        // Normally this should be formatted to a standard such as ISO8601
//        dictionary["ReleaseDate"] = releaseDate?.timeIntervalSinceNow
        
        return dictionary.toJsonData()
    }
}
