//
//  NewsModel.swift
//  EIT_Triangles
//
//  Created by Danil Peregorodiev on 24.06.2022.
//

import SwiftUI

struct NewsStruct: Identifiable {
    var id = UUID().uuidString
    var title: String
    var text: String
    var description: String
    var publishDate: Date
}

// рассматриваем варианты с базой данных или вызовой внешнего API
