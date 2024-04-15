//
//  NetworkManager.swift
//  CocktailBook
//
//  Created by Ajay Kunte on 14/04/24.
//

import Foundation
/*
    This Network is defined but it's not used as the FakeCocktail API implementation is provided
    This Network manager the implement the same logic and can be improvised more.
 */
struct NetworkManager {
    
    static let cocktailsBaseUrl = ""
    
    /// Fetch given url data
    /// - Parameter urlString: Url string for the api
    /// - Returns: Returns the dynamic response for generic model
    func fetch<T: Codable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else  {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        let result = try JSONDecoder().decode(T.self, from: data)
        return result
    }
}
