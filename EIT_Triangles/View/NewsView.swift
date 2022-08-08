//
//  NewsView.swift
//  EIT_Triangles
//
//  Created by Danil Peregorodiev on 24.06.2022.
//

import SwiftUI
import SDWebImageSwiftUI

//struct NewsView: View {
//    @ObservedObject var newsFeed = NewsFeed()
//    var body: some View {
//        NavigationView {
//            List(newsFeed) { (article: NewsListItem) in
//                NavigationLink(destination: NewsListItemView(article: article)) {
//                    NewsListItemListView(article: article)
//                        .onAppear {
//                            self.newsFeed.loadMoreArticles(currentItem: article)
//                        }
//                }
//
//            }
//            .navigationTitle("Новости")
//        }
//    }
//}
//
//struct NewsListItemView: View {
//    var article: NewsListItem
//    var body: some View {
//        VStack {
//            URLWebView(URLToDisplay: URL(string: article.url)!)
//                .edgesIgnoringSafeArea(.all)
//                .navigationTitle(article.title)
//        }
//    }
//}
//
//struct NewsListItemListView: View {
//    var article: NewsListItem
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading) {
//                Text("\(article.title)")
//                    .font(.headline)
//                Text("\(article.author ?? "No author")")
//                    .font(.subheadline)
//            }
//        }
//    }
//}

struct NewsFeedView: View {
    @ObservedObject var newsFeed = NewsFeed()
     
    var body: some View {
        NavigationView {
            List(newsFeed) { (article: NewsListItem) in
                NavigationLink(destination: NewsListItemView(article: article)) {
                    NewsListItemListView(article: article)
                        .onAppear {
                            self.newsFeed.loadMoreArticles(currentItem: article)
                    }
                }
            }
        .navigationBarTitle("Новости")
        }
    }
}
 
struct NewsListItemView: View {
    var article: NewsListItem
     
    var body: some View {
        VStack {
            UrlWebView(urlToDisplay: URL(string: article.url)!)
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitle(article.title)
        }
    }
}
 
struct NewsListItemListView: View {
    var article: NewsListItem
     
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 7) {
                Text("\(article.title)")
                    .font(.headline)
                
                Text("\(article.author ?? "Без авторства")")
                    .font(.subheadline)
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
    }
}
