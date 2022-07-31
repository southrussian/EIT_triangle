//
//  APIClient.swift
//  EIT_Triangles
//
//  Created by Danil Peregorodiev on 27.07.2022.
//

// https://newsapi.org/v2/top-headlines?country=ru&category=health&apiKey=d726cf4f37bb4142b2ecd0083e9c9f9f

// https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=d726cf4f37bb4142b2ecd0083e9c9f9f

import Foundation
import SwiftyJSON
import SDWebImageSwiftUI
import WebKit
import SwiftUI

struct MedicalData: Identifiable {
    var id: String
    var title: String
    var desc: String
    var url: String
    var image: String
}

class GetData: ObservableObject {
    @Published var news = [MedicalData]()
    
    init() {
        let source = "https://newsapi.org/v2/top-headlines?country=ru&category=health&apiKey=d726cf4f37bb4142b2ecd0083e9c9f9f"
        
        let url = URL(string: source)!
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { data, _, error in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            
            for i in json["articles"] {
                
                let title = i.1["title"].stringValue
                let decription = i.1["description"].stringValue
                let url = i.1["url"].stringValue
                let image = i.1["urlToImage"].stringValue
                let id = i.1["id"].stringValue
                
                DispatchQueue.main.async {
                    self.news.append(MedicalData(id: id, title: title, desc: decription, url: url, image: image))
                }
            }
        }
        .resume()
        
    }
}

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
