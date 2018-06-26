//
//  AddWork.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/23.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
typealias AddWorkUseCaseCompletionHandler = (_ works: Result<Work>) -> Void

protocol AddWorkUseCase {
    func add(parameters: AddWorkParameters, completionHandler: @escaping AddWorkUseCaseCompletionHandler)
}

// This class is used across all layers - Core, UI and Network
// It's not violating any dependency rules.
// However it might make sense for each layer do define it's own input parameters so it can be used independently of the other layers.
struct AddWorkParameters {
    // FIXME: API can't save works.
    var id : Int  // 作品のID
    var title : String   // 作品のタイトル
    var titleKana : String //  作品タイトルの読み仮名
    var media : String // リリース媒体 tv, ova, movie, web, other
    var mediaText : String // リリース媒体 (表記用) TV, OVA, 映画, Web, その他
    var seasonName : String? // リリース時期
    var seasonNameText : String? // リリース時期 (表記用)
    var releasedOn : Date? // リリース日
    var releasedOnAbout : Date? // 未確定な大体のリリース日
    var officialSiteUrl : String? // 公式サイトのURL
    var wikipediaUrl : String? // WikipediaのURL
    var twitterUsername : String? // 公式Twitterアカウントのusername
    var twitterHashtag : String? // Twitterの作品に関するハッシュタグ
    var malAnimeId : String? // MyAnimeListの作品ID
    var images : Images? // image URLs
    var episodesCount : Int // エピソード数
    var watchersCount : Int // 見てる / 見たい / 見た人の数
    var reviewsCount : Int // レビュー数
    var noEpisodes : Bool // エピソードが存在しない作品かどうか。例えば映画はエピソードが存在しない作品なので、true になります

}

class AddWorkUseCaseImplementation: AddWorkUseCase {
    let worksGateway: WorksGateway
    
    init(worksGateway: WorksGateway) {
        self.worksGateway = worksGateway
    }
    
    // MARK: - DeleteWorkUseCase
    
    func add(parameters: AddWorkParameters, completionHandler: @escaping (Result<Work>) -> Void) {
        self.worksGateway.add(parameters: parameters) { (result) in
            // Do any additional processing & after that call the completion handler
            completionHandler(result)
        }
    }
    
}
