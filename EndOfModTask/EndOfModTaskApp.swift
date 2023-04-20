//
//  EndOfModTaskApp.swift
//  EndOfModTask
//
//  Created by Alistair Fraser on 2023-04-19.
//

import SwiftUI

@main
struct EndOfModTaskApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                MovieView()
                    .tabItem {
                        Label("Fresh", systemImage: "carrot")
                    }
                
                SavedView()
                    .tabItem {
                        Label("Favourites", systemImage: "face.smiling")
                    }
            }
            //Make the database avaliable to all child views through the environment
                .environment(\.blackbirdDatabase, AppDatabase.instance)
        }
    }
}
