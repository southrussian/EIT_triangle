//
//  NewsView.swift
//  EIT_Triangles
//
//  Created by Danil Peregorodiev on 24.06.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsView: View {
    @StateObject var list = GetData()
    var body: some View {
        NavigationView {
            List(list.news) { i in
                VStack {
                    if i.image != "" {
                        WebImage(url: URL(string: i.image)!, options: .highPriority, context: nil)
                            .resizable()
                            .frame(width: 200, height: 150)
                            .cornerRadius(10)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(i.title).fontWeight(.heavy)
                        Text(i.desc).lineLimit(2)
                    }

                    


                }.padding(.vertical, 15)
            }
            
            .navigationTitle("Новости")
            
            
        }
        
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
