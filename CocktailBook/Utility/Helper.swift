//
//  Helper.swift
//  CocktailBook
//
//  Created by Ajay Kunte on 15/04/24.
//

import Foundation

final class Helper: ObservableObject {
    static let shared = Helper()
    @Published var selectedCocktails: [String] = []
    
    private init() {}
}
