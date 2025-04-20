//
//  05_oven.swift
//  Hello, Cheesecake
//
//  Created by Vicente Parmigiani on 14/04/25.
//

import SwiftUI

struct Oven: View {
    @Binding var currentTab: Int
    @State private var showNextButton = false
    @State private var isBetterPlaced = false
    @State private var isOnOven = false

    var body: some View {
        VStack {
            ZStack {
                VStack {
                    HStack {
                        Text("Coloque no forno")
                            .font(.title)
                        Spacer()
                    }
                    .padding(.top, 80)
                    .padding(.horizontal, 24)

                    HStack {
                        Text(
                            "Agora é hora de colocar a bolacha amanteigada no forno. Clique na tigela para primeiro ajustar a forma das bolachas e em seguida colocar a forma no forno."
                        )
                        .font(.body)
                        .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)

                    Spacer()

                    // Forma e fogão
                    VStack {
                        Image(
                            isBetterPlaced
                                ? "Forma 4"
                                : "Forma 3"
                        )
                        .resizable()
                        .scaledToFit()
                        .frame(width: Double.infinity, height: 100)
                        .padding(.top, 0)
                        .opacity(isOnOven ? 0 : 1)
                        .animation(.easeInOut(duration: 0.5), value: isOnOven)
                        .onTapGesture {
                            if !isBetterPlaced {
                                isBetterPlaced = true
                            } else {
                                isOnOven = true
                                showNextButton = true
                            }
                        }

                        Spacer()
                            .frame(height: 20)

                        Image(
                            isOnOven
                                ? "Forno 1"
                                : "Forno 0"
                        )
                        .resizable()
                        .scaledToFit()
                        .frame(width: isOnOven ? 300 : 220, height: isOnOven ? 300 : 220)
                        .animation(.spring(response: 0.6, dampingFraction: 0.7), value: isOnOven)
                    }
                    .padding(.top, 24)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)

                    Spacer()
                }

                // Botão para avançar para a próxima tela
                if showNextButton {
                    VStack {
                        Spacer()

                        Button {
                            currentTab += 1
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
