import SwiftUI

struct CocktailListView: View {
    @StateObject private var viewModel = CocktailListViewModel()
    @State private var searchText: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                GradientBackgroundView()

                VStack {
                    Spacer()

                    TextField(Constants.placeholder, text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)

                    Button(action: {
                        viewModel.searchCocktails(by: searchText)
                    }) {
                        Text(Constants.searchButtonTitle)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .font(.headline)
                    }
                    .padding(.horizontal)

                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.white)
                            .padding()
                    }

                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(viewModel.cocktails) { cocktail in
                                NavigationLink(destination: CocktailDetailView(cocktailId: cocktail.id)) {
                                    HStack {
                                        AsyncImage(url: URL(string: cocktail.imageUrl)) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 70, height: 70)
                                                .cornerRadius(10)
                                        } placeholder: {
                                            ProgressView()
                                                .frame(width: 70, height: 70)
                                        }
                                        Text(cocktail.name)
                                            .fontWeight(.bold)
                                            .padding(.leading)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                    }
                                    .padding()
                                    .background(Color.white.opacity(0.5)) // Set opacity to 0.5
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.top)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle(Constants.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private extension CocktailListView {
    enum Constants {
        static let placeholder = "Enter an ingredient..."
        static let searchButtonTitle = "Search"
        static let navigationTitle = "Search Cocktails"
    }
}
