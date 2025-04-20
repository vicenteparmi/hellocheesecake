//
//  12_strawberry_2.swift
//  Hello, Cheesecake
//
//  Created by Vicente Parmigiani on 14/04/25.
//

import SwiftUI

struct Strawberry_2: View {
    @Binding var currentTab: Int
    @State var addedJelly: Bool = false
    @State var showNextButton: Bool = false
    @State var addedSugar: Bool = false
    @State private var fireScale: CGFloat = 1.0

    var body: some View {
        VStack {
            ZStack {
                VStack {
                    HStack {
                        Text("Reduza os morangos")
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
                            "Adicione os morangos picados à uma panela com uma xícara de açúcar e leve ao fogo médio. Mexa até que os morangos estejam reduzidos e a calda esteja espessa."
                        )
                        .font(.body)
                        .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)

                    Spacer()

                    ZStack {
                        // Morangos
                        Image("Morangos")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .offset(x: -10, y: addedJelly ? -80 : -150)
                            .opacity(addedJelly ? 0 : addedSugar ? 1 : 0)
                            .animation(.easeInOut(duration: 0.5), value: addedJelly)
                            .onTapGesture {
                                addedJelly = true
                                
                                // Liga o fogo, depois de 3 segundos desliga e mostra o botão de próximo
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    showNextButton = true
                                }
                            }

                        // Açúcar
                        Image("Açúcar")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                            .rotationEffect(addedSugar ? .degrees(-45) : .degrees(0))
                            .offset(x: -10, y: addedSugar ? -80 : -150)
                            .opacity(addedSugar ? 0 : 1)
                            .animation(.easeInOut(duration: 0.5), value: addedSugar)
                            .onTapGesture {
                                addedSugar = true
                            }

                        // Panela
                        ZStack {
                            Image("Leiteira")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 160, height: 160)

                            // Fogo
                            Image("Fogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .scaleEffect(fireScale)
                                .offset(x: -10, y: 100)
                                .opacity(addedJelly ? 1 : 0)
                                .animation(.easeInOut(duration: 0.5), value: addedJelly)
                                .onChange(of: addedJelly) { newValue in
                                    if newValue {
                                        // Inicia a animação de pulsação do fogo
                                        withAnimation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
                                            fireScale = 1.1
                                        }
                                    } else {
                                        // Para a animação quando o fogo é desligado
                                        withAnimation {
                                            fireScale = 1.0
                                        }
                                    }
                                }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)

                    Spacer()
                        .frame(height: 20)

                    Spacer()
                }

                // Botão para avançar
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
                        .animation(.spring(response: 0.6, dampingFraction: 0.7), value: showNextButton)
                    }
                }
            }
        }
    }
}
