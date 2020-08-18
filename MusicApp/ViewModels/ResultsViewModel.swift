//
//  ResultsViewModel.swift
//  MusicApp
//
//  Created by Prabhdeep Singh on 17/08/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation

struct ResultsViewModel {
    
    let url: String
    let thumbnail: String
    let artist: String
    let songName: String
    var isPlaying: Bool = false
    
    init(result: Results) {
        self.thumbnail = result.thumbnail
        self.url = result.url
        self.artist = result.artist
        self.songName = result.name
    }
    
}
