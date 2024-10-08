import Foundation
import Combine

class CocktailDetailViewModel: ObservableObject {
    @Published var cocktailDetails: CocktailDetails?
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let cocktailService = CocktailService()
    
    func fetchCocktailDetails(by id: String) {
        cocktailService.fetchCocktailDetails(by: id)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.errorMessage = nil
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { details in
                self.cocktailDetails = details
            })
            .store(in: &cancellables)
    }
}
