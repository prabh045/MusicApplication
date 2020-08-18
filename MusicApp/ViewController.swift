//
//  ViewController.swift
//  MusicApp
//
//  Created by Prabhdeep Singh on 17/08/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit
import AVFoundation
import SnapKit

class ViewController: UIViewController {
  
    //MARK: Properties
   var musicViewModel = MusicViewModel()
   let musicTableView = UITableView()
   var filteredMusic = [ResultsViewModel]()
   let searchController = UISearchController(searchResultsController: nil)
   var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    var audioPlayer: AVPlayer?
    var isPlaying: Bool = false
    var alreadyPlayingUrl: String?
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchController()
        musicViewModel.retrieveMusicDetails()
        musicViewModel.resultViewModel.bind { [weak self] (_) in
            DispatchQueue.main.async {
                self?.musicTableView.reloadData()
            }
            
        }
        // Do any additional setup after loading the view.
    }
    
    private func setupTableView() {
        view.addSubview(musicTableView)
        musicTableView.delegate = self
        musicTableView.dataSource = self
        musicTableView.translatesAutoresizingMaskIntoConstraints = false
        
        musicTableView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaInsets.bottom)
            make.top.equalTo(view.safeAreaInsets.top)
        }
        
        musicTableView.register(MusicTableViewCell.self, forCellReuseIdentifier: "cell")
         
    }
    
    //Mark: Setup search Controller
    func setupSearchController(){
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Song"
        navigationItem.searchController = searchController
        navigationItem.title = "Awesome Music"
        definesPresentationContext = true
    }
    
    //MARK: Search Music
    func filterContentForMusicSearch(_ searchText: String) {
        filteredMusic = musicViewModel.resultViewModel.value.filter({ (resultViewModel) -> Bool in
            return resultViewModel.songName.lowercased().contains(searchText.lowercased())
        })
        musicTableView.reloadData()
    }
    
    //Mark: Play Methods
    func decideToPlayOrStop(from music: inout ResultsViewModel, isPlaying: Bool, at indexPath: IndexPath) {
        if isPlaying == false {
            playMusic(from: music.url)
            music.isPlaying = true
        } else {
            stopMusic()
            music.isPlaying = false
        }
        if isFiltering {
            filteredMusic[indexPath.row] = music
        } else {
            musicViewModel.resultViewModel.value[indexPath.row] = music
        }
        
    }
    
    func playMusic(from url: String) {
        print("Play Music Ran")
        let url = URL(string: url)
        audioPlayer = AVPlayer(url: url!)
        audioPlayer!.play()
        isPlaying = true
    }
    
    func stopMusic() {
        audioPlayer?.pause()
        audioPlayer = nil
        isPlaying = false
    }
    
    


}

//MARK: TableView Delegates
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredMusic.count : musicViewModel.resultViewModel.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MusicTableViewCell else {fatalError("Unaable to instatiniate cell")}
        cell.resultViewModel = isFiltering ? filteredMusic[indexPath.row] : musicViewModel.resultViewModel.value[indexPath.row]
        if cell.resultViewModel.isPlaying {
            cell.playImageView.image = UIImage(named: ImageEnum.pause.rawValue)
        } else {
              cell.playImageView.image = UIImage(named: ImageEnum.play.rawValue)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var music = isFiltering ? filteredMusic[indexPath.row] : musicViewModel.resultViewModel.value[indexPath.row]
        decideToPlayOrStop(from: &music, isPlaying: music.isPlaying, at: indexPath)
        //isPlaying ? stopMusic() : playMusic(from: music.url)
       
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
        

}

//MARK: Search extension
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForMusicSearch(searchBar.text ?? "")
    }
}

