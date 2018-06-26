//
//  ApiWorksGateway.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/23.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
// This protocol in not necessarily needed since it doesn't include any extra methods
// besides what WorksGateway already provides. However, if there would be any extra methods
// on the API that we would need to support it would make sense to have an API specific gateway protocol
protocol ApiWorksGateway: WorksGateway {
    
}

class ApiWorksGatewayImplementation: ApiWorksGateway {
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    // MARK: - ApiWorksGateway
    
    func fetchWorks(completionHandler: @escaping (Result<[Work]>) -> Void) {
        let worksApiRequest = WorksApiRequest()
        apiClient.execute(request: worksApiRequest) { (result: Result<ApiResponse<[ApiWork]>>) in
            switch result {
            case let .success(response):
                let works = response.entity.map { return $0.work }
                completionHandler(.success(works))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func add(parameters: AddWorkParameters, completionHandler: @escaping (Result<Work>) -> Void) {
        let addWorkApiRequest = AddWorkApiRequest(addWorkParameters: parameters)
        apiClient.execute(request: addWorkApiRequest) { (result: Result<ApiResponse<ApiWork>>) in
            switch result {
            case let .success(response):
                let work = response.entity.work
                completionHandler(.success(work))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func delete(work: Work, completionHandler: @escaping (Result<Void>) -> Void) {
        let deleteWorkApiRequest = DeleteWorkApiRequest(workId: work.id)
        apiClient.execute(request: deleteWorkApiRequest) { (result: Result<ApiResponse<VoidResponse>>) in
            switch result {
            case .success(_):
                completionHandler(.success(()))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
