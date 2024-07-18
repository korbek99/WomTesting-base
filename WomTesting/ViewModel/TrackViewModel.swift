//
//  TrackViewModel.swift
//  WomTesting
//
//  Created by Jose David Bustos H on 17-07-24.
//
//
//  TrackViewModel.swift
//  WomTesting
//
//  Created by Jose David Bustos H on 17-07-24.
//

import Foundation
import Combine

class TrackViewModel: ObservableObject {
    @Published var indicadores: [Track] = []
    private let networkService = NetworkService()
    var reloadList: (() -> Void)?
    var arrayOfList: [Track] = [] {
        didSet {
            reloadList?()
        }
    }
    
    init() {
        fetchIndicadores()
    }
    
    func fetchIndicadores() {
        networkService.fetchIndicadores { [weak self] response in
            guard let self = self, let response = response else { return }
            DispatchQueue.main.async {
                self.indicadores = response
                self.arrayOfList = self.indicadores 
            }
        }
    }
}
