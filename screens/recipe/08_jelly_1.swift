//
//  08_mix_3.swift
//  Hello, Cheesecake
//
//  Created by Vicente Parmigiani on 14/04/25.
//

import SwiftUI

struct Jelly_1: View {
    @Binding var currentTab: Int
    @State var addedJelly: Bool = false
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    HStack {
                        Text("Adicione a gelatina")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.top, 80)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)

                    HStack {
                        Text("Adicione a gelatina à mistura. Não se esqueça de dissolver em água conforme as instruções da embalagem.")
                            .font(.body)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)

                    Spacer()

                    ZStack {
                        // Tigela
                        Image("Bowl 1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                        
                        // Batedeira
                        Image("Gelatina")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 75)
                            .scaleEffect(isAnimating ? 1 : 0.95)
                            .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isAnimating)
                            .onAppear {
                                isAnimating = true
                            }
                            .offset(x: -10, y: addedJelly ? -80 : -150)
                            .opacity(addedJelly ? 0 : 1)
                            .animation(.easeInOut(duration: 0.5), value: addedJelly)
                            .onTapGesture {
                                play(sound: "zup.mp3")
                                addedJelly = true
                            }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)

                    Spacer()
                        .frame(height: 20)

                    Spacer()
                }

                // Botão para avançar
                if addedJelly {
                    VStack {
                        Spacer()
                        Button {
                            play(sound: "blingnext1.mp3")
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
                        .animation(.spring(response: 0.6, dampingFraction: 0.7), value: addedJelly)
                    }
                }
            }
        }
    }
}
