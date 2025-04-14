import SwiftUI

struct ContentView: View {
    @State private var step = 0
    @State private var currentTab = 0
    @State private var moveDirection: UnitPoint = .bottom
    @EnvironmentObject private var stepsData: StepsData
    
    var body: some View {
        if step == 0 {
            LaunchScreen(step: $step)
        } else if step == 1 {
            ZStack {
                VStack {
                    Spacer()
                        .frame(height: 24)
                    AnimatedViewState {
                        StepView(step: stepsData.getStep(at: currentTab))
                            .transition(
                                .asymmetric(
                                    insertion: .offset(y: moveDirection == .bottom ? 50 : -50)
                                        .combined(with: .opacity),
                                    removal: .offset(y: moveDirection == .bottom ? -50 : 50)
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
                    .background(Color.white)
                    .padding(.horizontal, 24)
                
                TabView(selection: Binding(
                    get: { currentTab },
                    set: { newValue in
                        moveDirection = newValue > currentTab ? .bottom : .top
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                            currentTab = newValue
                        }
                    }
                )) {
                    IngredientsView()
                        .tag(0)
                    EquipmentView()
                        .tag(1)
                    // Outras views de receita virão aqui
                }
                .tabViewStyle(.page)
                .animation(.easeInOut, value: currentTab)
                .overlay(alignment: .bottom) {
                    // Indicadores de página
                    HStack(spacing: 8) {
                        ForEach(0..<2) { index in
                            Circle()
                                .fill(currentTab == index ? .white : .white.opacity(0.5))
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.bottom, 20)
                }
                .background(AnimatedBackground())
            }
        }
    }
}
