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
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                let waveHeight: CGFloat = 5
                let waveCount = 10
                
                path.move(to: CGPoint(x: 0, y: height))
                path.addLine(to: CGPoint(x: 0, y: waveHeight))
                
                // Desenha as ondas no topo
                for i in 0...waveCount {
                    let x = width / CGFloat(waveCount) * CGFloat(i)
                    let y = i % 2 == 0 ? 0 : waveHeight
                    path.addQuadCurve(
                        to: CGPoint(x: x, y: y),
                        control: CGPoint(x: x - width/(CGFloat(waveCount)*2), y: y == 0 ? waveHeight : 0)
                    )
                }
                
                path.addLine(to: CGPoint(x: width, y: height))
                path.closeSubpath()
            }
            .fill(brown)
            .overlay(
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
            )
        }
    }
}

