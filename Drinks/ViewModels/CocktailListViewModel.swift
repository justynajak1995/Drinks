import Foundation
import Combine

class CocktailListViewModel: ObservableObject {
    @Published var cocktails: [Cocktail] = []
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let cocktailService = CocktailService()

    func searchCocktails(by ingredients: String) {
        let ingredientList = ingredients.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        
        let publisher = ingredientList.publisher
            .flatMap { ingredient in
                self.cocktailService.fetchCocktails(by: ingredient)
                    .catch { error -> Just<[Cocktail]> in
                        self.errorMessage = error.localizedDescription
                        return Just([])
                    }
            }
            .collect()
            .map { cocktailsArray in
                cocktailsArray.flatMap { $0 }
            }
            .eraseToAnyPublisher()

        publisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$cocktails)
    }
}
