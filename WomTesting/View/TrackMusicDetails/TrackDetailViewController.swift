//
//  TrackDetailViewController.swift
//  WomTesting
//
//  Created by Jose David Bustos H on 17-07-24.
//
import UIKit

class TrackDetailViewController: UIViewController {
    let track: Track
    lazy var trackImages: [String] = []

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.minimumLineSpacing = 10

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TrackImageCell.self, forCellWithReuseIdentifier: "TrackImageCell")
        collectionView.backgroundColor = .white

        return collectionView
    }()

    lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .lightGray
        return label
    }()

    lazy var albumLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .lightGray
        return label
    }()

    lazy var trackLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
          let button = UIButton(type: .system)
          button.setImage(UIImage(systemName: "heart"), for: .normal)
          button.tintColor = .red
          button.translatesAutoresizingMaskIntoConstraints = false
          button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
          return button
      }()

    init(track: Track) {
        self.track = track
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadImagesUI()
        configure(with: track)
    }

    private func loadImagesUI() {
        self.trackImages = [track.artworkUrl30, track.artworkUrl60, track.artworkUrl100]
    }

    private func setupUI() {
        title = "Track Details"
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(artistLabel)
        view.addSubview(albumLabel)
        view.addSubview(trackLabel)
        view.addSubview(favoriteButton)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: 300),
            collectionView.heightAnchor.constraint(equalToConstant: 300),

            artistLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            artistLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            artistLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            albumLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 8),
            albumLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            albumLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            trackLabel.topAnchor.constraint(equalTo: albumLabel.bottomAnchor, constant: 8),
            trackLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            trackLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            favoriteButton.topAnchor.constraint(equalTo: trackLabel.bottomAnchor, constant: 16),
            favoriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

     func configure(with track: Track) {
        artistLabel.text = "Artist: \(track.artistName)"
        albumLabel.text = "Album: \(track.collectionName)"
        trackLabel.text = "Track: \(track.trackName)"
    }
    
    @objc func favoriteButtonTapped() {
           saveFavoriteTrack(track)
    }

    func saveFavoriteTrack(_ track: Track) {
            var favorites = UserDefaults.standard.array(forKey: "favoriteTracks") as? [Data] ?? []
            if let encodedTrack = try? JSONEncoder().encode(track) {
                favorites.append(encodedTrack)
                UserDefaults.standard.set(favorites, forKey: "favoriteTracks")
                NotificationCenter.default.post(name: NSNotification.Name("FavoriteAdded"), object: nil)
                print("Track saved to favorites.")
                
                let alert = UIAlertController(title: "Saved Track", message: "Track saved to favorites.", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   present(alert, animated: true, completion: nil)
            }
    }
}

extension TrackDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trackImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrackImageCell", for: indexPath) as! TrackImageCell
        let imageName = trackImages[indexPath.item]

        if let url = URL(string: imageName) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                    }
                }
            }
        }
        return cell
    }
}
