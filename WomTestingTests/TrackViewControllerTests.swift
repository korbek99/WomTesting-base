//
//  TrackViewControllerTests.swift
//  WomTestingTests
//
//  Created by Jose David Bustos H on 17-07-24.
//
import XCTest
@testable import WomTesting

class TrackViewControllerTests: XCTestCase {
    
    var trackViewController: TrackViewController!
    var mockViewModel: MockTrackViewModel!
    
    override func setUp() {
        super.setUp()
        mockViewModel = MockTrackViewModel()
        trackViewController = TrackViewController()
        trackViewController.viewModel = mockViewModel
        _ = trackViewController.view // Para cargar la vista y los elementos de la interfaz
    }
    
    override func tearDown() {
        trackViewController = nil
        mockViewModel = nil
        super.tearDown()
    }
    
    func testViewControllerNotNil() {
        XCTAssertNotNil(trackViewController, "El TrackViewController debería ser no nulo")
    }
    
    func testTableViewNotNil() {
        XCTAssertNotNil(trackViewController.tableView, "El tableView debería ser no nulo")
    }
    
    func testSearchBarNotNil() {
        XCTAssertNotNil(trackViewController.searchBar, "El searchBar debería ser no nulo")
    }
    
    func testTableViewDelegateAndDataSource() {
        XCTAssertTrue(trackViewController.tableView.delegate === trackViewController, "El delegate de tableView debería ser el TrackViewController")
        XCTAssertTrue(trackViewController.tableView.dataSource === trackViewController, "El dataSource de tableView debería ser el TrackViewController")
    }
    
    func testNumberOfRowsInSection() {
        mockViewModel.arrayOfList = [Track(wrapperType: "data1", kind: "data1", artistId: 1, collectionId: 1, trackId: 1, artistName: "data1", collectionName: "data1", trackName: "data1", collectionCensoredName: "data1", trackCensoredName: "data1", artistViewUrl: "data1", collectionViewUrl: "data1", trackViewUrl: "data1", previewUrl: "data1", artworkUrl30: "data1", artworkUrl60: "data1", artworkUrl100: "data1", collectionPrice: 1.1, trackPrice: 1.1, releaseDate: "data1", collectionExplicitness: "data1", trackExplicitness: "data1", discCount: 1, discNumber: 1, trackCount: 1, trackNumber: 1, trackTimeMillis: 1, country: "data1", currency: "data1", primaryGenreName: "data1", isStreamable: true), Track(wrapperType: "data1", kind: "data1", artistId: 1, collectionId: 1, trackId: 1, artistName: "data1", collectionName: "data1", trackName: "data1", collectionCensoredName: "data1", trackCensoredName: "data1", artistViewUrl: "data1", collectionViewUrl: "data1", trackViewUrl: "data1", previewUrl: "data1", artworkUrl30: "data1", artworkUrl60: "data1", artworkUrl100: "data1", collectionPrice: 1.1, trackPrice: 1.1, releaseDate: "data1", collectionExplicitness: "data1", trackExplicitness: "data1", discCount: 1, discNumber: 1, trackCount: 1, trackNumber: 1, trackTimeMillis: 1, country: "data1", currency: "data1", primaryGenreName: "data1", isStreamable: true)]
        
        trackViewController.tableView.reloadData()
        let numberOfRows = trackViewController.tableView(trackViewController.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 2, "El número de filas debería ser igual al número de tracks en el array")
    }
    
    func testCellForRowAt() {
        let track = Track(wrapperType: "data1", kind: "data1", artistId: 1, collectionId: 1, trackId: 1, artistName: "data1", collectionName: "data1", trackName: "data1", collectionCensoredName: "data1", trackCensoredName: "data1", artistViewUrl: "data1", collectionViewUrl: "data1", trackViewUrl: "data1", previewUrl: "data1", artworkUrl30: "data1", artworkUrl60: "data1", artworkUrl100: "data1", collectionPrice: 1.1, trackPrice: 1.1, releaseDate: "data1", collectionExplicitness: "data1", trackExplicitness: "data1", discCount: 1, discNumber: 1, trackCount: 1, trackNumber: 1, trackTimeMillis: 1, country: "data1", currency: "data1", primaryGenreName: "data1", isStreamable: true)
        mockViewModel.arrayOfList = [track]
        trackViewController.tableView.reloadData()
        let cell = trackViewController.tableView(trackViewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? TrackTableViewCell
        XCTAssertNotNil(cell, "La celda debería ser de tipo TrackTableViewCell")
        //XCTAssertEqual(cell?.textLabel?.text, track.artistName, "La celda debería mostrar el nombre del artista")
    }
    
    func testSearchFiltering() {
        let track1 = Track(wrapperType: "data1", kind: "data1", artistId: 1, collectionId: 1, trackId: 1, artistName: "data1", collectionName: "data1", trackName: "data1", collectionCensoredName: "data1", trackCensoredName: "data1", artistViewUrl: "data1", collectionViewUrl: "data1", trackViewUrl: "data1", previewUrl: "data1", artworkUrl30: "data1", artworkUrl60: "data1", artworkUrl100: "data1", collectionPrice: 1.1, trackPrice: 1.1, releaseDate: "data1", collectionExplicitness: "data1", trackExplicitness: "data1", discCount: 1, discNumber: 1, trackCount: 1, trackNumber: 1, trackTimeMillis: 1, country: "data1", currency: "data1", primaryGenreName: "data1", isStreamable: true)
        
        let track2 = Track(wrapperType: "data1", kind: "data1", artistId: 1, collectionId: 1, trackId: 1, artistName: "data1", collectionName: "data1", trackName: "data1", collectionCensoredName: "data1", trackCensoredName: "data1", artistViewUrl: "data1", collectionViewUrl: "data1", trackViewUrl: "data1", previewUrl: "data1", artworkUrl30: "data1", artworkUrl60: "data1", artworkUrl100: "data1", collectionPrice: 1.1, trackPrice: 1.1, releaseDate: "data1", collectionExplicitness: "data1", trackExplicitness: "data1", discCount: 1, discNumber: 1, trackCount: 1, trackNumber: 1, trackTimeMillis: 1, country: "data1", currency: "data1", primaryGenreName: "data1", isStreamable: true)
        
        mockViewModel.arrayOfList = [track1, track2]
        trackViewController.searchBar(trackViewController.searchBar, textDidChange: "Artist 1")
        
//        XCTAssertTrue(trackViewController.isSearchActive, "La búsqueda debería estar activa")
//        XCTAssertEqual(trackViewController.filteredTracks.count, 1, "Debería haber 1 track después del filtrado")
        //XCTAssertEqual(trackViewController.filteredTracks[0].artistName, "Artist 1", "El track filtrado debería ser 'Artist 1'")
    }
    
    func testSearchBarCancelButtonClicked() {
        trackViewController.isSearchActive = true
        trackViewController.searchBar.text = "Artist"
        trackViewController.searchBarCancelButtonClicked(trackViewController.searchBar)
        
        XCTAssertFalse(trackViewController.isSearchActive, "La búsqueda debería estar inactiva")
        XCTAssertEqual(trackViewController.searchBar.text, "", "El texto del searchBar debería estar vacío")
    }
}

// Mock ViewModel
class MockTrackViewModel: TrackViewModel {
    override func fetchIndicadores() {
        // Simula la obtención de datos sin realizar ninguna operación real
    }
}
