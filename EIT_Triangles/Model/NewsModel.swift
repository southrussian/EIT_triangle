//
//  NewsModel.swift
//  EIT_Triangles
//
//  Created by Danil Peregorodiev on 24.06.2022.
//

import SwiftUI

struct News: Identifiable {
    var id = UUID().uuidString
    var title: String
    var text: String
    var description: String
    var publishDate: Date
}
