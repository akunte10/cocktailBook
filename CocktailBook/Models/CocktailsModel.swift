//
//  CocktailsModel.swift
//  CocktailBook
//
//  Created by Ajay Kunte on 14/04/24.
//

import Foundation

// MARK: - Cocktail
struct CocktailsModel: Codable {
    let id, name, type, shortDescription: String?
    let longDescription: String?
    let preparationMinutes: Int?
    let imageName: String?
    let ingredients: [String]?
}

typealias Cocktails = [CocktailsModel]
