//
//  MovieView.swift
//  EndOfModTask
//
//  Created by Alistair Fraser on 2023-04-19.
//

import Blackbird
import SwiftUI

struct MovieView: View {
    
    //MARK: Stored properties
    
    //Access the connection to the database (needed to add a new record)
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    //0.0 is invisible, 1.0 is visible
    @State var titleOpacity = 0.0
    
    //The current joke to display
    @State var currentMovie: Movie?
    
    //Track whether current joke has been saved to database
    @State var savedToDatabase = false
    
    //MARK: Computed properties
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                
                if let currentMovie = currentMovie {
                    //Show the movie if it can be unwrapped(if currentJoke is not nil
                    Text(currentMovie.t)
                        .font(.title)
                        .multilineTextAlignment(.center)
                    
                    Button(action:  {
                        withAnimation(.easeIn(duration: 1.0)) {
                            titleOpacity = 1.0
                        }
                    }, label: {
                        Image(systemName: "arrow.down.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                            .tint(.black)
                    })
                    Text(currentMovie.t)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .opacity(titleOpacity)
                    
                    Text(currentMovie.plot)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .opacity(titleOpacity)
                    
                    Text(currentMovie.poster)
                    
                    Text(currentMovie.runtime)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .opacity(titleOpacity)
                    
                    Text(currentMovie.IMDBRating)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .opacity(titleOpacity)
                    
                    Text(currentMovie.RottenTomatoes)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .opacity(titleOpacity)
                    
                    Text(currentMovie.MetacriticRating)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .opacity(titleOpacity)
                    
                } else {
                    //Show a spinning wheel indicator until the movie is loaded
                    ProgressView()
                }
                
                Spacer()
                Button(action: {
                    // Reset the interface
                    titleOpacity = 0.0
                    
                    Task {
                        // Get another movie
                        withAnimation {
                            currentMovie = nil
                        }
                        currentMovie = await NetworkService.fetch()
                        
                        //Rest so that button to allow saving new movie to database is enabled
                        savedToDatabase = false
                    }
                }, label: {
                    Text("Generate a new movie")
                })
                .disabled(titleOpacity == 0.0 ? true : false)
                .buttonStyle(.borderedProminent)
                
                Button (action: {
                    
                    Task {
                        //Write to database
                        if let currentMovie = currentMovie {
                            try await db!.transaction { core in
                                try core.query("INSERT INTO Movie (id, t, y, plot, poster, runtime, IMDBRating, RottenTomatoes, MetacriticRating) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                                               currentMovie.id,
                                               currentMovie.t,
                                               currentMovie.y,
                                               currentMovie.plot,
                                               currentMovie.poster,
                                               currentMovie.runtime,
                                               currentMovie.IMDBRating,
                                               currentMovie.MetacriticRating,
                                               currentMovie.RottenTomatoes)
                                
                                //Record that this movie has been saved
                                savedToDatabase = true
                                }
                            }
                        }
                }, label: {
                    Text("Save to watch list")
                })
                //Disable button until movie is shown
                .disabled(titleOpacity == 0.0 ? true : false)
                //Once saved disable the button so it cant be saved twice
                .disabled(savedToDatabase == true ? true : false)
                //Use another colour to differentiate from first button
                .tint(.green)
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Random Movies")
        }
        //Create an asynchronous task to be performed as this view appears
        .task {
            if currentMovie == nil {
                currentMovie = await NetworkService.fetch()
            }
        }
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView()
        //Make the database avaliable to this view in XCode previews
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
