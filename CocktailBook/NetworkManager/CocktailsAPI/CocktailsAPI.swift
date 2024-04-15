import Foundation
import Combine

protocol CocktailsAPI: AnyObject {
    
    var cocktailsPublisher: AnyPublisher<Cocktails, CocktailsAPIError> { get }
    func fetchCocktails(_ handler: @escaping (Result<Cocktails, CocktailsAPIError>) -> Void)
}
