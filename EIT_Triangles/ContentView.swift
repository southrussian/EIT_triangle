//
//  ContentView.swift
//  EIT_Triangles
//
//  Created by Danil Peregorodiev on 20.02.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Triangle")
                    .font(.callout)
                    .foregroundColor(.black)
                    .bold()
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
