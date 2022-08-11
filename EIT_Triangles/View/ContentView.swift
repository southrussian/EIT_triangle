//
//  ContentView.swift
//  EIT_Triangles
//
//  Created by Danil Peregorodiev on 20.02.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //Home()
        
        TabView {
            NewsFeedView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Главная")
                }
            
                PatientsView()
                    .tabItem {
                        Image(systemName: "person.3.sequence")
                        Text("Пациенты")
                }
            
            Text("Личный кабинет")
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Профиль")
                }
            
        }
        .accentColor(.mint)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
