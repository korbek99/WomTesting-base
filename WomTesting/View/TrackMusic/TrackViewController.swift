//
//  TrackViewController.swift
//  WomTesting
//
//  Created by Jose David Bustos H on 17-07-24.
//
import UIKit

class TrackViewController: UIViewController {
     var viewModel = TrackViewModel()
     var filteredTracks: [Track] = []
     var isSearchActive: Bool = false
  
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search Tracks"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    lazy var tableView: UITableView = {
        let table: UITableView = .init()
        table.delegate = self
        table.dataSource = self
        table.register(TrackTableViewCell.self, forCellReuseIdentifier: "TrackTableViewCell")
        table.rowHeight = 120.0
        table.separatorColor = UIColor.orange
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchIndicadores()
    }

    private func setupUI() {
        title = "Tracks"
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.reloadList = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension TrackViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? filteredTracks.count : viewModel.arrayOfList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.identifier, for: indexPath) as? TrackTableViewCell else {
            return UITableViewCell()
        }
        let track = isSearchActive ? filteredTracks[indexPath.row] : viewModel.arrayOfList[indexPath.row]
        cell.configure(with: track)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = isSearchActive ? filteredTracks[indexPath.row] : viewModel.arrayOfList[indexPath.row]
        let detailVC = TrackDetailViewController(track: track)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension TrackViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearchActive = false
            filteredTracks.removeAll()
        } else {
            isSearchActive = true
            filteredTracks = viewModel.arrayOfList.filter { $0.artistName.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchActive = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
}
