import SwiftUI

struct ContentView: View {
    @State private var step = 0
    @State private var currentTab = 0
    @EnvironmentObject private var stepsData: StepsData
    
    var body: some View {
        if step == 0 {
            // Exibe a cena 3D diretamente
            LaunchScreen(step: $step)
                .transition(.opacity)
            
        } else if step == 1 {
            ZStack {
                TabView(selection: Binding(
                    get: { currentTab },
                    set: { newValue in
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                            currentTab = newValue
                        }
                    }
                )) {
                    IngredientsView()
                        .tag(0)
                    EquipmentView()
                        .tag(1)
                }
                .tabViewStyle(.page)
                .animation(.easeInOut, value: currentTab)
                .background(AnimatedBackground())
                
                VStack {
                    Spacer()
                        .frame(height: 24)
                    AnimatedViewState {
                        StepView(step: stepsData.getStep(at: currentTab))
                            .transition(
                                .asymmetric(
                                    insertion: .offset(y: -50)
                                        .combined(with: .opacity),
                                    removal: .offset(y: 50)
                                        .combined(with: .opacity)
                                )
                            )
                    }
                    .animation(.spring(response: 0.4, dampingFraction: 0.8), value: currentTab)
                    .id(currentTab)
                    .padding()
                    Spacer()
                }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .padding(.horizontal, 24)
            }
        }
    }
}
