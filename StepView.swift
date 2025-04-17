//
//  StepView.swift
//  Hello, Cheesecake
//
//  Created by Vicente Parmigiani on 14/04/25.
//

import SwiftUI

struct StepView: View {
    let step: Step
    
    var body: some View {
        Text(step.content)
            .font(.custom("Times New Roman", size: 24))
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .transition(.asymmetric(
                insertion: .move(edge: .leading).combined(with: .opacity),
                removal: .move(edge: .leading).combined(with: .opacity)
            ))
    }
}
