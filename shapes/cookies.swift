//
//  cookies.swift
//  Hello, Cheesecake
//
//  Created by Vicente Parmigiani on 14/04/25.
//
import SwiftUI

struct CookiePart: View {
    let brown = Color(red: 47/255, green: 23/255, blue: 15/255)
    
    var body: some View {
        Rectangle()
            .fill(brown)
            .overlay(
                GeometryReader { geometry in
                    Canvas { context, size in
                        for _ in 0..<100 {
                            let x = CGFloat.random(in: 0...size.width)
                            let y = CGFloat.random(in: 0...size.height)
                            let radius = CGFloat.random(in: 2...4)
                            
                            context.fill(
                                Path(ellipseIn: CGRect(x: x, y: y, width: radius, height: radius)),
                                with: .color(Color.white.opacity(0.1))
                            )
                        }
                    }
                }
            )
    }
}
    
