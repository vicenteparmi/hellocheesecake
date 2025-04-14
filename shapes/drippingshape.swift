//
//  drippingshape.swift
//  Hello, Cheesecake
//
//  Created by Vicente Parmigiani on 14/04/25.
//
import SwiftUI

struct DrippingShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Start from top-left
        path.move(to: CGPoint(x: 0, y: 0))
        
        // Draw to top-right
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        
        // Draw to bottom-right
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        
        // Draw drips across the bottom
        let drips = 8
        let width = rect.width / CGFloat(drips)
        
        for i in (0...drips).reversed() {
            let x = CGFloat(i) * width
            let dropHeight = CGFloat.random(in: 20...50)
            
            path.addCurve(
                to: CGPoint(x: x, y: rect.height),
                control1: CGPoint(x: x + width/3, y: rect.height + dropHeight),
                control2: CGPoint(x: x + width/6, y: rect.height)
            )
        }
        
        // Complete the shape
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: 0))
        
        return path
    }
}
