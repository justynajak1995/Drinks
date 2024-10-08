import Foundation
import Combine

class CocktailService {
    private var cancellables = Set<AnyCancellable>()

    func fetchCocktails(by ingredient: String) -> AnyPublisher<[Cocktail], Error> {
        let urlString = Endpoints.searchCocktails(by: ingredient)
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CocktailResponse.self, decoder: JSONDecoder())
            .map { $0.drinks }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func fetchCocktailDetails(by id: String) -> AnyPublisher<CocktailDetails, Error> {
        let urlString = Endpoints.getCocktailDetails(by: id)
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CocktailDetailsResponse.self, decoder: JSONDecoder())
            .map { $0.drinks.first! }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
