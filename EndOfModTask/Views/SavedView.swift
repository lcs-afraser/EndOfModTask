//
//  SavedView.swift
//  EndOfModTask
//
//  Created by Alistair Fraser on 2023-04-20.
//


import Blackbird
import SwiftUI

struct SavedView: View {
    //MARK: Stored properties
    
    //List of favourite Movies
    @BlackbirdLiveModels({ db in
        try await Movie.read(from: db)
    }) var savedMovies
    
    //MARK: Computed properties
    var body: some View {
        List(savedMovies.results) { currentMovie in
            VStack(alignment: .leading) {
                Text(currentMovie.t)
                    .bold()
                Text(currentMovie.poster)
            }
        }
        .navigationTitle("Watch List")
    }
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
        //Make the database avaliable to this view in XCode previews
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
