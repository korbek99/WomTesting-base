//
//  FavoritesTableViewCell.swift
//  WomTesting
//
//  Created by Jose David Bustos H on 17-07-24.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    static let identifier = "FavoritesTableViewCell"
 
    lazy var trackImageView: UIImageView = {
           let image: UIImageView = .init()
           image.contentMode = .scaleAspectFit
           image.layer.cornerRadius = 10.0
           image.layer.masksToBounds = true
           image.translatesAutoresizingMaskIntoConstraints = false
           return image
       }()
    
    lazy var artistLabel: UILabel = {
        let label: UILabel = .init()
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.textColor = .lightGray
            return label
    }()
    
    lazy var albumLabel: UILabel = {
        let label: UILabel = .init()
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.textColor = .lightGray
            return label
    }()
    
    lazy var trackLabel: UILabel = {
        let label: UILabel = .init()
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .lightGray
            return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(trackImageView)
        contentView.addSubview(artistLabel)
        contentView.addSubview(albumLabel)
        contentView.addSubview(trackLabel)
        
        NSLayoutConstraint.activate([
            trackImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            trackImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            trackImageView.widthAnchor.constraint(equalToConstant: 100),
            trackImageView.heightAnchor.constraint(equalToConstant: 100),
            
            artistLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            artistLabel.leadingAnchor.constraint(equalTo: trackImageView.trailingAnchor, constant: 8),
            artistLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            albumLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 4),
            albumLabel.leadingAnchor.constraint(equalTo: trackImageView.trailingAnchor, constant: 8),
            albumLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            trackLabel.topAnchor.constraint(equalTo: albumLabel.bottomAnchor, constant: 4),
            trackLabel.leadingAnchor.constraint(equalTo: trackImageView.trailingAnchor, constant: 8),
            trackLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            trackLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with track: Track) {
        artistLabel.text = "Artist: \(track.artistName)"
        albumLabel.text = "Album: \(track.collectionName)"
        trackLabel.text = "Track: \(track.trackName)"
        if let url = URL(string: track.artworkUrl60) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.trackImageView.image = image
                    }
                }
            }
        }
    }
}

