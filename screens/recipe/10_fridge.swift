//
//  10_fridge.swift
//  Hello, Cheesecake
//
//  Created by Vicente Parmigiani on 14/04/25.
//

import SwiftUI

struct Fridge: View {
    @Binding var currentTab: Int
    @State private var showNextButton = false
    @State private var isPoured = false
    @State private var isOnFidge = false

    var body: some View {
        VStack {
            ZStack {
                VStack {
                    HStack {
                        Text("Coloque na forma e leve à geladeira")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.top, 80)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)

                    HStack {
                        Text(
                            "Vire a tigela e despeje a mistura na forma. Depois, leve à geladeira por 4 horas ou até que a mistura esteja bem firme."
                        )
                        .font(.body)
                        .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)

                    Spacer()

                    // Forma e tigela
                    if !isOnFidge {
                        VStack {
                            Image(
                                isPoured
                                    ? "Bowl 0"
                                    : "Bowl 1"
                            )
                            .resizable()
                            .scaledToFit()
                            .frame(width: Double.infinity, height: 100)
                            .opacity(isOnFidge ? 0 : 1)
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

                    // Timer de 4 horas
                    if isOnFidge {
                        // Ícone
                        Image(systemName: "clock.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.black)
                            .padding(.horizontal, 24)
                            .transition(.scale.combined(with: .opacity))
                            .animation(.easeInOut(duration: 0.6), value: isOnFidge)

                        Text("Geladeira")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding(.horizontal, 24)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .animation(.easeInOut(duration: 0.7).delay(0.1), value: isOnFidge)

                        Text("4 horas")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding(.horizontal, 24)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .animation(.easeInOut(duration: 0.7).delay(0.2), value: isOnFidge)
                    }

                    // Forma
                    Image(
                        isPoured
                            ? "Forma 5"
                            : "Forma 4"
                    )
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .animation(.easeInOut(duration: 0.5), value: isPoured)
                    .onTapGesture {
                        if !isOnFidge && isPoured {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isOnFidge = true
                                showNextButton = true
                            }
                        }
                    }

                    // Texto informando que precisa ir para a geladeira
                    if isPoured && !isOnFidge {
                        Text("Aperte na forma para levar à geladeira")
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
                            withAnimation(.easeInOut) {
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
        .onAppear {
            // Preparar as imagens no início
            preloadImages()
        }
    }

    // Função para pré-carregar as imagens
    private func preloadImages() {
        let _ = [
            UIImage(named: "Forno 0"),
            UIImage(named: "Forno 1"),
            UIImage(named: "Forma 3"),
        ]
    }
}
