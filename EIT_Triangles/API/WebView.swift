//
//  WebView.swift
//  EIT_Triangles
//
//  Created by Danil Peregorodiev on 31.07.2022.
//

import SwiftUI
import WebKit

struct URLWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    var URLToDisplay: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: URLToDisplay))
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
