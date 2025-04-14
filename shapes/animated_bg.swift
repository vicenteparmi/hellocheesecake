//
//  animated_bg.swift
//  Hello, Cheesecake
//
//  Created by Vicente Parmigiani on 14/04/25.
//

import SwiftUI

struct AnimatedBackground: View {
    @State private var stars: [Star] = []
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.orange.opacity(0.1)
                
                // Gradient
                RadialGradient(
                    colors: [.orange.opacity(0.1), .orange.opacity(0.5)],
                    center: .center,
                    startRadius: 0,
                    endRadius: 500
                )
                
                ForEach(stars) { star in
                    Circle()
                        .fill(Color.white.opacity(1))
                        .frame(width: star.size, height: star.size)
                        .position(star.position)
                        .opacity(star.opacity)
                }
            }
            .onAppear {
                for _ in 0..<100 {
                    stars.append(Star(
                        size: CGFloat.random(in: 1...10),
                        position: CGPoint(
                            x: CGFloat.random(in: 0...geometry.size.width),
                            y: CGFloat.random(in: 0...geometry.size.height)
                        )
                    ))
                }
                
                animateStars()
            }
        }
        .ignoresSafeArea()
    }
    
    private func animateStars() {
        for index in stars.indices {
            withAnimation(
                Animation
                    .easeInOut(duration: Double.random(in: 0.5...2.0))
                    .repeatForever()
                    .delay(Double.random(in: 0...2))
            ) {
                stars[index].opacity = Double.random(in: 0.1...1.0)
            }
        }
    }
}

struct Star: Identifiable {
    let id = UUID()
    let size: CGFloat
    let position: CGPoint
    var opacity: Double = 0
}
