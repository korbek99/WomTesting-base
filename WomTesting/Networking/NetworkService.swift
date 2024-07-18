//
//  NetworkService.swift
//  WomTesting
//
//  Created by Jose David Bustos H on 17-07-24.
//
import Foundation

class NetworkService {
    func fetchIndicadores(completion: @escaping ([Track]?) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=pop&country=us&entity=song&limit=20"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response received")
                completion(nil)
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("HTTP Error: \(httpResponse.statusCode)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let trackResponse = try JSONDecoder().decode(TrackResponse.self, from: data)
                completion(trackResponse.results)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()

    }
}
