//
//  FavoritesViewController.swift
//  WomTesting
//
//  Created by Jose David Bustos H on 17-07-24.
//
import UIKit

class FavoritesViewController: UIViewController {
    var favorites: [Track] = []

    lazy var tableView: UITableView = {
        let table: UITableView = .init()
        table.delegate = self
        table.dataSource = self
        table.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "FavoritesTableViewCell")
        table.rowHeight = 120.0
        table.separatorColor = UIColor.orange
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadFavorites()
        NotificationCenter.default.addObserver(self, selector: #selector(favoriteAdded), name: NSNotification.Name("FavoriteAdded"), object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("FavoriteAdded"), object: nil)
    }

    private func setupUI() {
        title = "Favorites"
        view.backgroundColor = .white
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

     func loadFavorites() {
        if let savedData = UserDefaults.standard.array(forKey: "favoriteTracks") as? [Data] {
            favorites = savedData.compactMap { try? JSONDecoder().decode(Track.self, from: $0) }
            tableView.reloadData()
        }
    }

    @objc private func favoriteAdded() {
        loadFavorites()
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as! FavoritesTableViewCell
        let track = favorites[indexPath.row]
        cell.configure(with: track)
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favorites.remove(at: indexPath.row)
            saveFavorites()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    private func saveFavorites() {
        let encodedData = favorites.compactMap { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(encodedData, forKey: "favoriteTracks")
    }
}

