//
//  13_combining.swift
//  Hello, Cheesecake
//
//  Created by Vicente Parmigiani on 14/04/25.
//

import SwiftUI

struct Combining: View {
    @Binding var currentTab: Int
    @State private var showNextButton = false
    @State private var isPoured = false
    @State private var isFinished = false

    var body: some View {
        VStack {
            ZStack {
                VStack {
                    HStack {
                        Text("Adicione a cobertura")
                            .font(.title)
                        Spacer()
                    }
                    .padding(.top, 80)
                    .padding(.horizontal, 24)

                    HStack {
                        Text(
                            "Despeje a cobertura sobre a forma para finalizar a montagem do cheesecake."
                        )
                        .font(.body)
                        .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)

                    Spacer()

                    // Forma e tigela
                    if !isFinished {
                        VStack {
                            Image("Leiteira")
                            .resizable()
                            .scaledToFit()
                            .frame(width: Double.infinity, height: 100)
                            .opacity(isFinished ? 0 : 1)
                            .rotationEffect(isPoured ? .degrees(-120) : .degrees(0))
                            .animation(.easeInOut(duration: 0.5), value: isPoured)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    isPoured = true
                                }
                            }
                        }
                        .padding(.top, 24)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)
                        .transition(.opacity)
                    }

                    // Ícone de finalização
                    if isFinished {
                        // Ícone
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.green)
                            .padding(.horizontal, 24)
                            .transition(.scale.combined(with: .opacity))
                            .animation(.easeInOut(duration: 0.6), value: isFinished)

                        Text("Receita finalizada!")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding(.horizontal, 24)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .animation(.easeInOut(duration: 0.7).delay(0.1), value: isFinished)
                    }

                    // Forma
                    Image(
                        isPoured
                            ? isFinished
                                ? "Cheesecake"
                                : "Forma 6"
                            : "Forma 5"
                    )
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(isFinished ? 1.25 : 1)
                    .frame(width: 240, height: 200)
                    .padding(.bottom, isFinished ? 24 : 0)
                    .animation(.easeInOut(duration: 0.5), value: isPoured)
                    .onTapGesture {
                        if !isFinished && isPoured {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isFinished = true
                                showNextButton = true
                            }
                        }
                    }

                    // Texto informando que precisa ir para a geladeira
                    if isPoured && !isFinished {
                        Text("Aperte na forma para desenformar")
                            .font(.body)
                            .foregroundColor(.black)
                            .padding(.horizontal, 24)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .animation(.easeInOut(duration: 0.5), value: isPoured)
                    }

                    Spacer()
                }

                // Botão para avançar para a próxima tela
                if showNextButton {
                    VStack {
                        Spacer()

                        Button {
                            withAnimation(.bouncy) {
                                // Avançar para a próxima tela
                                currentTab += 1
                            }
                        } label: {
                            Text("Continuar")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.orange)
                                .cornerRadius(15)
                                .shadow(radius: 2)
                        }
                        .padding(.horizontal, 40)
                        .padding(.bottom, 30)
                        .transition(.move(edge: .bottom))
                        .animation(
                            .spring(response: 0.6, dampingFraction: 0.7), value: showNextButton)
                    }
                }
            }
        }
    }
}
