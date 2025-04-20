//
//  animated_bg.swift
//  Hello, Cheesecake
//
//  Created by Vicente Parmigiani on 14/04/25.
//

import SwiftUI

struct AnimatedBackgroundHome: View {
    @State private var starxs: [Starx] = []
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Gradient
                RadialGradient(
                    colors: [.orange.opacity(0), .orange.opacity(0.2)],
                    center: .center,
                    startRadius: 0,
                    endRadius: 500
                )
                
                ForEach(starxs) { starx in
                    Circle()
                        .fill(Color.white.opacity(1))
                        .frame(width: starx.size, height: starx.size)
                        .position(starx.position)
                        .opacity(starx.opacity)
                }
            }
            .onAppear {
                for _ in 0..<100 {
                    starxs.append(Starx(
                        size: CGFloat.random(in: 1...10),
                        position: CGPoint(
                            x: CGFloat.random(in: 0...geometry.size.width),
                            y: CGFloat.random(in: 0...geometry.size.height)
                        )
                    ))
                }
                
                animateStarxs()
            }
        }
        .ignoresSafeArea()
    }
    
    private func animateStarxs() {
        for index in starxs.indices {
            withAnimation(
                Animation
                    .easeInOut(duration: Double.random(in: 0.5...2.0))
                    .repeatForever()
                    .delay(Double.random(in: 0...2))
            ) {
                starxs[index].opacity = Double.random(in: 0.1...1.0)
            }
        }
    }
}

struct Starx: Identifiable {
    let id = UUID()
    let size: CGFloat
    let position: CGPoint
    var opacity: Double = 0
}
