import Foundation

struct Endpoints {
    private static let baseURL = "https://www.thecocktaildb.com/api/json/v1/1/"
    
    static func searchCocktails(by ingredient: String) -> String {
        return "\(baseURL)search.php?s=\(ingredient)"
    }
    
    static func getCocktailDetails(by id: String) -> String {
        return "\(baseURL)lookup.php?i=\(id)"
    }
}
