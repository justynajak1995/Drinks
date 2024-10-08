import Foundation

struct CocktailDetails: Codable {
    let id: String
    let name: String
    let instructions: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case instructions = "strInstructions"
        case imageUrl = "strDrinkThumb"
    }
}
