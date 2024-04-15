//
//  CocktailCellView.swift
//  CocktailBook
//
//  Created by Ajay Kunte on 13/04/24.
//

import SwiftUI

struct CocktailCellView: View {
    @State var title: String
    @State var subtitle: String
    @State var isFavorite: Bool = false
    var onSelect: () -> Void
    
    init(title: String, subtitle: String, onSelect: @escaping () -> Void) {
        self.title = title
        self.subtitle = subtitle
        self.onSelect = onSelect
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // Title
                Text(title)
                    .font(.title)
                    .foregroundColor(isFavorite ? .purple : .black)
                Spacer()
                
                // Show Favorite icon if added to favorites
                Image(isFavorite ? ImageConstants.favoriteImage : "")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            // Subtitle
            Text(subtitle)
                .font(.subheadline)
        }
        .onAppear {
            self.isFavorite = Helper.shared.selectedCocktails.contains(title)
        }
        .onTapGesture {
            // On tap action
            self.onSelect()
        }
        .padding(.all, 20)
    }
}
