import Foundation

enum CocktailError: Error, LocalizedError {
    case networkError
    case decodingError
    case noDataError
    
    var errorDescription: String? {
        switch self {
        case .networkError:
            return "A network error occurred. Please check your internet connection."
        case .decodingError:
            return "An error occurred while decoding the data."
        case .noDataError:
            return "No data found for the specified ingredient."
        }
    }
}
