//
//  Home.swift
//  EIT_Triangles
//
//  Created by Danil Peregorodiev on 20.02.2022.
//

import SwiftUI
import UIKit

struct Home: View {
    var body: some View {
        
        NavigationView {
            VStack(spacing: 1) {
                
                HStack (alignment: .center, spacing: 0) {
                    ReversedTriangle()
                        .fill(.cyan)
                        .frame(width: 50, height: 50)
                        .offset(x: 46)
                    Triangle()
                        .fill(.blue)
                        .frame(width: 50, height: 50)
                        .offset(x: 23)
                        
                    ReversedTriangle()
                        .fill(.cyan)
                        .frame(width: 50, height: 50)
//                        .offset(y: 5)
                    Triangle()
                        .fill(.blue)
                        .frame(width: 50, height: 50)
                        .offset(x: -23)
                    ReversedTriangle()
                        .fill(.cyan)
                        .frame(width: 50, height: 50)
                        .offset(x: -46)
                }

                HStack(alignment: .center, spacing: 0) {
                    Triangle()
                        .fill(.blue)
                        .frame(width: 50, height: 50)
                        .offset(x: 46)
                    ReversedTriangle()
                        .fill(.cyan)
                        .frame(width: 50, height: 50, alignment: .center)
                        .offset(x: 23)
                    Triangle()
                        .fill(.blue)
                        .frame(width: 50, height: 50)
//                        .offset(y: -5)
                    ReversedTriangle()
                            .fill(.cyan)
                            .frame(width: 50, height: 50)
                            .offset(x: -23)
                    Triangle()
                        .fill(.blue)
                        .frame(width: 50, height: 50)
                        .offset(x: -46)
                    
                }
            }
            .frame(width: 100, height: 100)
            .padding()
            .navigationTitle("EIT Triangles")
            
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct ReversedTriangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minX))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        
        return path
    }
}


