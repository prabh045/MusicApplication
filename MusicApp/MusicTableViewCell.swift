//
//  MusicTableViewCell.swift
//  MusicApp
//
//  Created by Prabhdeep Singh on 17/08/20.
//  Copyright © 2020 Prabh. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class MusicTableViewCell: UITableViewCell {
    
    var resultViewModel: ResultsViewModel! {
        didSet {
            songNameLabel.text = resultViewModel.songName
            artistNameLabel.text = resultViewModel.artist
            thumbNailImageView.kf.setImage(with: URL(string: resultViewModel.thumbnail))
            thumbNailImageView.kf.indicatorType = .activity
           // detailTextLabel?.text = resultViewModel
        }
    }
    
    let thumbNailImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 35
        image.clipsToBounds = true
      
        return image
    }()
    
    let songNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    //add play image
    let playImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 13
        img.clipsToBounds = true
        img.image = UIImage(named: "play")
        return img
    }()
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(thumbNailImageView)
        containerView.addSubview(songNameLabel)
        containerView.addSubview(artistNameLabel)
        self.contentView.addSubview(containerView)
        self.contentView.addSubview(playImageView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupConstraints() {
        
        thumbNailImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.leading.equalTo(self.contentView.layoutMargins.left + 10.0)
            make.width.equalTo(70)
            make.height.equalTo(70)
         }
        
        containerView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.leading.equalTo(self.thumbNailImageView.snp.trailing).offset(10)
            make.trailing.equalTo(self.playImageView.snp.leading).offset(-10)
            make.height.equalTo(40)
            
        }

        songNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.containerView.snp.top)
            make.leading.equalTo(self.containerView.snp.leading)
            make.trailing.equalTo(self.containerView.snp.trailing)
        }

        
        artistNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.songNameLabel.snp.bottom)
            make.leading.equalTo(self.containerView.snp.leading)
        }
        
        playImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-20)
            make.leading.equalTo(self.containerView.snp.trailing).offset(10)
        }
        
        playImageView.widthAnchor.constraint(equalToConstant:30).isActive = true
        playImageView.heightAnchor.constraint(equalToConstant:30).isActive = true
//     playImageView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-20).isActive = true
//    playImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
    }
    
    
    
}
