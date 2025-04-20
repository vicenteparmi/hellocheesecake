//
//  Closure.swift
//  Hello, Cheesecake
//
//  Created by Vicente Parmigiani on 14/04/25.
//

import SwiftUI

struct ClosureView: View {
    @Binding var currentTab: Int
    @State private var scale: CGFloat = 0.5
    @State private var rotation: Double = 0
    @State private var opacity: Double = 0
    @State private var showText = false
    @State private var showCredits = false

    var body: some View {
        ZStack {
            // Fundo com gradiente
            RadialGradient(
                gradient: Gradient(colors: [Color.pink.opacity(0.5), Color.pink.opacity(0.8)]),
                center: .center,
                startRadius: 100,
                endRadius: 400
            )
            .ignoresSafeArea()
            .background(Color.white)

            VStack {
                // Cheesecake animado
                Image("Cheesecake")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .scaleEffect(scale)
                    .rotationEffect(.degrees(rotation - 5))
                    .opacity(opacity)
                    .shadow(radius: 10)
                    .onAppear {
                        withAnimation(
                            .spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0)
                        ) {
                            scale = 1.2
                            opacity = 1
                        }

                        withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                            rotation = 10
                        }
                    }

                Spacer()
                    .frame(height: 50)

                if showText {
                    VStack(spacing: 20) {
                        Text("Parabéns!")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.28), radius: 4, x: 0, y: 4)

                        Text("Você completou a receita do cheesecake!")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(0.9))

                        Spacer()
                            .frame(height: 16)

                        VStack {
                            Button(action: {
                                showCredits = true
                            }) {
                                Text("Ver Créditos")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(
                                        Capsule()
                                            .fill(Color.pink)
                                    )
                            }

                            Button(action: {
                                withAnimation(.spring()) {
                                    currentTab = 0
                                }
                            }) {
                                Text("Início")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(
                                        Capsule()
                                            .fill(Color.pink.opacity(0.3))
                                    )
                            }
                        }
                        .padding(.horizontal)
                        .scaleEffect(showText ? 1 : 0.5)
                        .opacity(showText ? 1 : 0)
                        .animation(.spring().delay(0.3), value: showText)
                    }
                    .transition(.scale.combined(with: .opacity))
                    .padding(.horizontal, 24)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    withAnimation(.spring()) {
                        showText = true
                    }
                }
            }
        }
        .sheet(
            isPresented: $showCredits
        ) {
            CreditsView()
                .interactiveDismissDisabled()
                .presentationDragIndicator(.hidden)
        }
        .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
    }
}
