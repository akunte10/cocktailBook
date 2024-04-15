//
//  CocktailDetailsView.swift
//  CocktailBook
//
//  Created by Ajay Kunte on 15/04/24.
//

import SwiftUI

struct CocktailDetailsView: View {
    @State var viewModel: CocktailsModel
    @State var isFavorite: Bool = false
    
    init(viewModel: CocktailsModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    // Title
                    Text(viewModel.name ?? "")
                        .font(.title)
                        .padding(.leading, 20)
                    Spacer()
                    Button {
                        isFavorite = !isFavorite
                        if isFavorite {
                            // Add to favorites
                            if !Helper.shared.selectedCocktails.contains(viewModel.name ?? "") {
                                Helper.shared.selectedCocktails.append(viewModel.name ?? "")
                            }
                        } else {
                            // Remove from favorites
                            Helper.shared.selectedCocktails = Helper.shared.selectedCocktails.filter({$0 != viewModel.name ?? ""})
                        }
                    } label: {
                        // Show Favorite icon if added to favorites
                        Image(isFavorite ? ImageConstants.favoriteImage : ImageConstants.favorite)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.trailing, 20)
                    }
                }
                // Subtitle
                HStack {
                    Image(systemName: ImageConstants.timer)
                    Text("\(viewModel.preparationMinutes ?? 0) \(Constants.minutesText)")
                        .font(.subheadline)
                }
                .padding(.leading, 20)
                Image(ImageConstants.cocktail)
                    .resizable()
                    .frame(height: 180)
                    .padding(.all, 10)
                // Subtitle
                VStack(alignment: .leading) {
                    Text(viewModel.longDescription ?? "")
                        .font(.subheadline)
                    Text(Constants.ingredientsText)
                        .font(.headline)
                        .padding(.vertical, 20)
                    
                    ForEach(viewModel.ingredients ?? [], id: \.self) { item in
                        VStack {
                            HStack {
                                Image(systemName: ImageConstants.playFillIcon)
                                Text(item)
                                    .font(.subheadline)
                            }
                        }
                        .padding(.vertical, 2)
                    }
                }
                .padding(.horizontal, 20)
            }
            .onAppear{
               isFavorite = Helper.shared.selectedCocktails.contains(viewModel.name ?? "")
            }
        }
    }
}

struct CocktailDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailDetailsView(viewModel: CocktailsModel(id: "", name: "", type: "", shortDescription: "", longDescription: "", preparationMinutes: 0, imageName: "", ingredients: []))
    }
}
