//
//  HomeView.swift
//  CocktailBook
//
//  Created by Ajay Kunte on 13/04/24.
//

import SwiftUI

/// Enum for Segment options
enum Segments: String, CaseIterable, Identifiable {
    case All
    case Alchoholic
    case NonAlchoholic = "Non-Alchoholic"
    var id: Self { self }
}

struct HomeView: View {
    @State private var selected: Segments = .All
    @ObservedObject var viewModel = CocktailsViewModel()
    @State var showDetailsPage: Bool = false
    @State var selectedCocktails: Cocktails = Cocktails()
    @State var selectedCocktail: CocktailsModel?

    init() {
        setupSegmentControl()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    // Title
                    Text(Constants.homeScreenTitle)
                        .font(.title)
                        .padding(.leading, 20)
                        .padding(.top, 20)
                    
                    // Segment Control View
                    customSegmentView
                    Divider().frame(height: 10).foregroundColor(.black)
                   
                    if viewModel.cocktails?.count ?? 0 > 0 {
                        cocktailsListView
                    } else {
                        if #available(iOS 15.0, *) {
                            if viewModel.loading {
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        ProgressView().scaleEffect(2.5).tint(.purple)
                                        Spacer()
                                    }
                                    Spacer()
                                }
                            }
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                }
                NavigationLink("", isActive: $showDetailsPage, destination: {
                    if let cocktail = selectedCocktail {
                        CocktailDetailsView(viewModel: cocktail)
                    }
                })
                .onAppear {
                    viewModel.fetchCocktails()
                }
                .padding(.top, 50)
            }
        }
    }
    
    /// Make UI for Custom Segment View
    @ViewBuilder var customSegmentView: some View {
        VStack {
            Picker(Constants.pickerName, selection: $selected) {
                ForEach(Segments.allCases) { value in
                    Text(value.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            .background(Color.white)
            .padding(.horizontal, 40)
        }
    }
    
    /// Make UI for Cocktails list
    @ViewBuilder var cocktailsListView: some View {
        ScrollView (showsIndicators: false) {
            if let selectedCocktails = updateSelection(selected: selected), !selectedCocktails.isEmpty {
                ForEach(selectedCocktails.indices, id: \.self) { index in
                    let cocktail = selectedCocktails[index]
                    CocktailCellView(title: cocktail.name ?? "", subtitle: cocktail.shortDescription ?? "", onSelect: {
                        // Navigate to details screen
                        selectedCocktail = cocktail
                        showDetailsPage = true
                    })
                    if index < selectedCocktails.count - 1 {
                        Divider()
                    }
                }
            }
        }
    }
    
    /// Update the list of cocktails based on the selection
    /// - Parameter selected: Segments as input
    /// - Returns: List of cocktails for selected segment
    private func updateSelection(selected: Segments) -> Cocktails {
        switch selected {
        case .Alchoholic:
            return viewModel.getAlchoholicCocktails()
        case .NonAlchoholic:
            return viewModel.getNonAlchoholicCocktails()
        case .All:
            return viewModel.cocktails ?? Cocktails()
        }
    }
    
    /// Configure Segment Control UI
    private func setupSegmentControl() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .purple
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
}
