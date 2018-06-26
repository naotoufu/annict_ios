//
//  WorkTableViewCell.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/24.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation

import UIKit

class WorkTableViewCell: UITableViewCell, WorkCellView {
    
    @IBOutlet weak var workTitleLabel: UILabel!
    @IBOutlet weak var workAuthorLabel: UILabel!
    @IBOutlet weak var workReleaseDateLabel: UILabel!
    
    
    func display(title: String) {
        workTitleLabel.text = title
    }
    
    func display(author: String) {
        workAuthorLabel.text = author
    }
    
    func display(releaseDate: String) {
        workReleaseDateLabel.text = releaseDate
    }
    
}
