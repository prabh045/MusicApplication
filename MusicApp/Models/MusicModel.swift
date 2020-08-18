//
//  MusicModel.swift
//  MusicApp
//
//  Created by Prabhdeep Singh on 17/08/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation

struct MusicModel: Codable {
    var results: Array<Results>
}

struct Results: Codable {
    var id: Int
    var name: String
    var url: String
    var thumbnail: String
    var artist: String
    var category: Category
}

struct Category: Codable {
    var id: Int
    var uuid: String
    var name: String
    var icon: String
    var isActive: Bool
    var isHidden: Bool
    var updatedAt: String
    var createdAt: String
}


