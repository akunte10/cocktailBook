//
//  CocktailsViewModel.swift
//  CocktailBook
//
//  Created by Ajay Kunte on 14/04/24.
//

import Foundation

class CocktailsViewModel: ObservableObject {
    // Initialize Fake Cocktail Api instance
    private let cocktailsAPI: CocktailsAPI = FakeCocktailsAPI()
    
    // Published properties
    @Published var cocktails: Cocktails?
    @Published var alcholicCocktails: Cocktails?
    @Published var nonAlcholicCocktails: Cocktails?
    @Published var loading = false
    
    /// Fetch cocktails data
    func fetchCocktails() {
        DispatchQueue.main.async {
            self.loading = true
        }
        cocktailsAPI.fetchCocktails { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.cocktails = data
                    self.loading = false
                }
            case .failure(let error):
                print(error)
                self.loading = false
            }
        }
    }
    
    /// Filters the cocktails list for alchoholic data
    /// - Returns: Alchoholic Cocktails
    func getAlchoholicCocktails() -> Cocktails {
        guard let allCocktails = cocktails else { return Cocktails()}
        return allCocktails.filter({$0.type?.lowercased() == Constants.alchoholic})
    }
    
    /// Filters the cocktails list for non-alchoholic data
    /// - Returns: Non-Alchoholic Cocktails
    func getNonAlchoholicCocktails() -> Cocktails {
        guard let allCocktails = cocktails else { return Cocktails()}
        return allCocktails.filter({$0.type?.lowercased() == Constants.nonAlchoholic})
    }
}
