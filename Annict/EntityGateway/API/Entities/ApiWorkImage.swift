//
//  ApiWorkImage.swift
//  Annict
//
//  Created by 伊東直人 on 2018/07/11.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
struct ApiWorkImage: Decodable{
    let id: Int
    let title: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey{
        case work
    }
    
    enum WorkCodingKeys: String, CodingKey {
        case id
        case title
        case imageUrl = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let workContainer = try container.nestedContainer(keyedBy: WorkCodingKeys.self, forKey: .work)
        
        self.id = try workContainer.decode(Int.self, forKey: .id)
        self.title = try workContainer.decode(String.self, forKey: .title)
        self.imageUrl = try workContainer.decode(String.self, forKey: .imageUrl)
    }
}

extension ApiWorkImage {
    var workImage: WorkImage {
        return WorkImage(id: self.id, title: self.title, image_url: self.imageUrl)
    }
}

