//
//  MuiscViewModel.swift
//  MusicApp
//
//  Created by Prabhdeep Singh on 17/08/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import Foundation

class MusicViewModel {
    
    private var musicModel: MusicModel?
    var resultViewModel = Box([ResultsViewModel]())
    
    
    func retrieveMusicDetails() {
        MusicService.retrieveMusicData { (musicModel, error) in
            if let error = error {
                print("Error in retrieving music Data \(error.localizedDescription)")
                return
            }
            self.musicModel = musicModel
            self.resultViewModel.value = musicModel?.results.map({ (result) -> ResultsViewModel in
                return ResultsViewModel(result: result)
            }) ?? []
        }
    }
}
