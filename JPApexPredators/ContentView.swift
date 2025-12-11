//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Jean Camargo on 08/12/25.
//

import SwiftUI

struct ContentView: View {
    let predators = Predators()
    
    @State var searchText = ""
    @State var alphabetical = false
    
    var filteredDinos: [ApexPredator] {
        predators.sort(by: alphabetical)
        
        return predators.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredDinos) { predators in
                NavigationLink {
                    Image(predators.image)
                        .resizable()
                        .scaledToFit()
                } label: {
                    HStack{
                        // Dinosaur imagme
                        Image(predators.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        
                        VStack(alignment: .leading) {
                            // Name
                            Text(predators.name)
                                .fontWeight(.bold)
                            
                            // Type
                            Text(predators.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predators.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
            }
            
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
