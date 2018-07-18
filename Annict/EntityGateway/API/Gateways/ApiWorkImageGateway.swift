//
//  ApiWorkImageGateway.swift
//  Annict
//
//  Created by 伊東直人 on 2018/07/11.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
protocol ApiWorkImageGateway: WorkImageGateway {
    
}

class ApiWorkImageGatewayImplementation: ApiWorkImageGateway {
    
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    // MARK: - ApiWorkImageGateway
    
    func fetchWorkImage(id: String, completionHandler: @escaping FetchWorkImageEntityGatewayCompletionHandler) {
        let workImageApiRequest = WorkImageApiRequest()
        apiClient.execute(request: workImageApiRequest) { (result: Result<DecodableApiResponse<ApiWorkImage>>) in
            switch result {
            case let .success(response):
                let work = response.entity.workImage
                completionHandler(.success(work))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }

}
