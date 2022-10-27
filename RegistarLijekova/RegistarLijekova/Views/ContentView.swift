//
//  ContentView.swift
//  RegistarLijekova
//
//  Created by Amir Sljivic on 19. 10. 2022..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView(buttonPressed: false)
                .tabItem{
                    Label("Registar Lijekova", systemImage: "pills.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
