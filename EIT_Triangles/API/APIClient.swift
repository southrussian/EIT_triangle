//
//  APIClient.swift
//  EIT_Triangles
//
//  Created by Danil Peregorodiev on 27.07.2022.
//

// https://newsapi.org/v2/top-headlines?country=ru&category=health&apiKey=d726cf4f37bb4142b2ecd0083e9c9f9f&page=

// https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=d726cf4f37bb4142b2ecd0083e9c9f9f&page=

// "https://newsapi.org/v2/everything?q=apple&sortBy=popularity&apiKey=55c250f06e1144c29a3ec4d2530adbe5&language=en&page="

import Foundation
 
class NewsFeed: ObservableObject, RandomAccessCollection {
    typealias Element = NewsListItem
     
    @Published var newsListItems = [NewsListItem]()
     
    var startIndex: Int { newsListItems.startIndex }
    var endIndex: Int { newsListItems.endIndex }
    var loadStatus = LoadStatus.ready(nextPage: 1)
     
    var urlBase = "https://newsapi.org/v2/top-headlines?country=ru&category=health&apiKey=d726cf4f37bb4142b2ecd0083e9c9f9f&page="
  
    init() {
        loadMoreArticles()
    }
     
    subscript(position: Int) -> NewsListItem {
        return newsListItems[position]
    }
     
    func loadMoreArticles(currentItem: NewsListItem? = nil) {
         
        if !shouldLoadMoreData(currentItem: currentItem) {
            return
        }
        guard case let .ready(page) = loadStatus else {
            return
        }
        loadStatus = .loading(page: page)
        let urlString = "\(urlBase)\(page)"
         
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: parseArticlesFromResponse(data:response:error:))
        task.resume()
    }
     
    func shouldLoadMoreData(currentItem: NewsListItem? = nil) -> Bool {
        guard let currentItem = currentItem else {
            return true
        }
         
        for n in (newsListItems.count - 4)...(newsListItems.count-1) {
            if n >= 0 && currentItem.uuid == newsListItems[n].uuid {
                return true
            }
        }
        return false
    }
     
    func parseArticlesFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            loadStatus = .parseError
            return
        }
        guard let data = data else {
            print("No data found")
            loadStatus = .parseError
            return
        }
         
        let newArticles = parseArticlesFromData(data: data)
        DispatchQueue.main.async {
            self.newsListItems.append(contentsOf: newArticles)
            if newArticles.count == 0 {
                self.loadStatus = .done
            } else {
                guard case let .loading(page) = self.loadStatus else {
                    fatalError("loadSatus is in a bad state")
                }
                self.loadStatus = .ready(nextPage: page + 1)
            }
        }
    }
     
    func parseArticlesFromData(data: Data) -> [NewsListItem] {
        var response: NewsApiResponse
        do {
            response = try JSONDecoder().decode(NewsApiResponse.self, from: data)
        } catch {
            print("Error parsing the JSON: \(error)")
            return []
        }
         
        if response.status != "ok" {
            print("Status is not ok: \(response.status)")
            return []
        }
         
        return response.articles ?? []
    }
     
    enum LoadStatus {
        case ready (nextPage: Int)
        case loading (page: Int)
        case parseError
        case done
    }
}
 
class NewsApiResponse: Codable {
    var status: String
    var articles: [NewsListItem]?
}
 
class NewsListItem: Identifiable, Codable {
    var uuid = UUID()
     
    var author: String?
    var title: String
    var url: String
     
    enum CodingKeys: String, CodingKey {
        case author, title, url
    }
}



//import Foundation
//
//class NewsFeed: ObservableObject, RandomAccessCollection {
//    typealias Element = NewsListItem
//
//    @Published var newsListItems = [NewsListItem]()
//
//    var startIndex: Int { newsListItems.startIndex }
//    var endIndex: Int { newsListItems.endIndex }
//    var loadStatus = LoadStatus.ready(nextPage: 1)
//
//    var urlBase = "https://newsapi.org/v2/everything?q=apple&from=2022-07-29&to=2022-07-29&sortBy=popularity&apiKey=d726cf4f37bb4142b2ecd0083e9c9f9f"
//
//    init() {
//        loadMoreArticles()
//    }
//
//    subscript(position: Int) -> NewsListItem {
//        return newsListItems[position]
//    }
//
//    func loadMoreArticles(currentItem: NewsListItem? = nil) {
//        if !shouldLoadMoreData(currentItem: currentItem) {
//            return
//        }
//        guard case let .ready(page) = loadStatus else {
//            return
//        }
//        loadStatus = .loading(page: page)
//        let urlString = "\(urlBase)\(page)"
//
//        let url = URL(string: urlString)!
//        let task = URLSession.shared.dataTask(with: url, completionHandler: parseArticlesFromResponse(data:response:error:))
//        task.resume()
//    }
//
//    func shouldLoadMoreData(currentItem: NewsListItem? = nil) -> Bool {
//        guard let currentItem = currentItem else {
//            return true
//        }
//        for i in (newsListItems.count - 4)...(newsListItems.count - 1) {
//            if i >= 0 && currentItem.uuid == newsListItems[i].uuid {
//                return true
//            }
//        }
//        return false
//    }
//
//    func parseArticlesFromResponse(data: Data?, response: URLResponse?, error: Error?) {
//        guard error == nil else {
//            print("Error: \(error!)")
//            loadStatus = .parseError
//            return
//        }
//        guard let data = data else {
//            print("Data not found")
//            loadStatus = .parseError
//            return
//        }
//        let newArticles = parseArticlesFromData(data: data)
//        DispatchQueue.main.async {
//            self.newsListItems.append(contentsOf: newArticles)
//            if newArticles.count == 0 {
//                self.loadStatus = .done
//            }
//            else {
//                guard case let .loading(page) = self.loadStatus else {
//                    fatalError("Load status in a bad state")
//                }
//                self.loadStatus = .ready(nextPage: page + 1)
//            }
//        }
//    }
//
//    func parseArticlesFromData(data: Data) -> [NewsListItem] {
//        var response: NewsApiResponse
//        do {
//            response = try JSONDecoder().decode(NewsApiResponse.self, from: data)
//        } catch {
//            print("Error parsing the JSON file: \(error)")
//            return []
//        }
//
//        if response.status != "ok!" {
//            print("Status is not OK!: \(response.status)")
//            return []
//        }
//        return response.articles ?? []
//    }
//
//    enum LoadStatus {
//        case ready (nextPage: Int)
//        case loading (page: Int)
//        case parseError
//        case done
//    }
//
//}
//
//class NewsApiResponse: Codable {
//    var status: String
//    var articles: [NewsListItem]?
//}
//
//class NewsListItem: Identifiable, Codable {
//    var uuid = UUID()
//    var author: String
//    var title: String
//    var url: String
//
//    enum CodingKeys: String, CodingKey {
//        case author, title, url
//    }
//}


//import SwiftyJSON
//import SDWebImageSwiftUI
//import WebKit
//import SwiftUI
//
//struct MedicalData: Identifiable {
//    var id: String
//    var title: String
//    var desc: String
//    var url: String
//    var image: String
//}
//
//class GetData: ObservableObject {
//    @Published var news = [MedicalData]()
//
//    init() {
//        let source = "https://newsapi.org/v2/top-headlines?country=ru&category=health&apiKey=d726cf4f37bb4142b2ecd0083e9c9f9f"
//
//        let url = URL(string: source)!
//        let session = URLSession(configuration: .default)
//
//        session.dataTask(with: url) { data, _, error in
//            if error != nil {
//                print((error?.localizedDescription)!)
//                return
//            }
//
//            let json = try! JSON(data: data!)
//
//            for i in json["articles"] {
//
//                let title = i.1["title"].stringValue
//                let decription = i.1["description"].stringValue
//                let url = i.1["url"].stringValue
//                let image = i.1["urlToImage"].stringValue
//                let id = i.1["id"].stringValue
//
//                DispatchQueue.main.async {
//                    self.news.append(MedicalData(id: id, title: title, desc: decription, url: url, image: image))
//                }
//            }
//        }
//        .resume()
//
//    }
//}

//struct WebView: UIViewRepresentable {
//    func makeUIView(context: Context) -> some UIView {
//        <#code#>
//    }
//
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//        <#code#>
//    }
//}

//struct MedicalData: Codable, Identifiable {
//    var id: Int?
//    var title: String
//    var url: String
//    var urlToImage: String
//    var publishedAt: String
//    var content: String
//    var description: String
//}

//@MainActor class MedicalAPI: ObservableObject {
//    @Published var news: [MedicalData] = []
//
//    func getData() {
//        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=d726cf4f37bb4142b2ecd0083e9c9f9f") else {
//            return
//        }
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data else {
//                let tempError = error!.localizedDescription
//                DispatchQueue.main.async {
//                    self.news = [MedicalData(id: 0, title: tempError, url: "Error", urlToImage: "Error", publishedAt: "Error", content: "Error", description: "Error")]
//                }
//                return
//            }
//
//            let medicalData = try! JSONDecoder().decode([MedicalData].self, from: data)
//
//            DispatchQueue.main.async {
//                print("Loaded successfully. Articles: \(medicalData.count)")
//                self.news = medicalData
//            }
//        }.resume()
//    }
//}
