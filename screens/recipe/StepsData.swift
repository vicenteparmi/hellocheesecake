//
//  StepsData.swift
//  Hello, Cheesecake
//
//  Created by Vicente Parmigiani on 14/04/25.
//

import SwiftUI

class StepsData: ObservableObject {
    @Published var currentStep: Int = 0
    @Published var steps: [Step] = [
        Step(title: "Ingredientes", content: "Aqui estão os ingredientes necessários"),
        Step(title: "Equipamentos", content: "Você precisará destes equipamentos"),
        // Mais etapas serão adicionadas aqui
    ]
    
    func getStep(at index: Int) -> Step {
        guard index < steps.count else { return steps[0] }
        return steps[index]
    }
    
    func getCurrentStep() -> Step {
        return steps[currentStep]
    }
    
    func nextStep() {
        if currentStep < steps.count - 1 {
            currentStep += 1
        }
    }
    
    func previousStep() {
        if currentStep > 0 {
            currentStep -= 1
        }
    }
}

class Step: Identifiable {
    let id = UUID()
    var title: String
    var content: String
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
}
