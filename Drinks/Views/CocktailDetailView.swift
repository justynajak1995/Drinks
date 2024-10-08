import SwiftUI

struct CocktailDetailView: View {
    let cocktailId: String
    @StateObject private var viewModel = CocktailDetailViewModel()
    
    var body: some View {
        ZStack {
            GradientBackgroundView()
            
            VStack {
                if let cocktail = viewModel.cocktailDetails {
                    AsyncImage(url: URL(string: cocktail.imageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                            .cornerRadius(15)
                            .shadow(radius: 10)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text(cocktail.name)
                        .font(.largeTitle)
                        .padding()
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .transition(.scale)
                    
                    Text(cocktail.instructions)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.top)
                        .transition(.slide)
                } else {
                    Text(Constants.loadingMessage)
                        .foregroundColor(.white)
                        .onAppear {
                            viewModel.fetchCocktailDetails(by: cocktailId)
                        }
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .navigationTitle(Constants.navigationTitle)
            .padding()
        }
    }
}

private extension CocktailDetailView {
    enum Constants {
        static let loadingMessage = "Loading details..."
        static let navigationTitle = "Cocktail Details"
    }
}
