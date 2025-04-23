//
//  03_cookies_2.swift
//  Hello, Cheesecake
//
//  Created by Vicente Parmigiani on 14/04/25.
//

import SpriteKit
import SwiftUI
import Subsonic

struct Cookies_2: View {
    @Binding var currentTab: Int
    @State private var butterAdded = false
    @State private var isAnimating = false
    @State private var showNextButton = false
    @State private var spoonRotation: Double = 0
    @State private var butterPosition: CGSize = .zero
    @State private var butterOpacity: Double = 1.0

    var body: some View {
        VStack {
            ZStack {
                VStack {
                    HStack {
                        Text("Adicione a manteiga")
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
                            "Agora é hora de adicionar manteiga à nossa mistura de bolachas. Clique na colher para despejar a manteiga na tigela."
                        )
                        .font(.body)
                        .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)

                    Spacer()

                    // Container da animação
                    ZStack {
                        // Tigela (sprite)
                        Image(
                            butterAdded
                                ? "Forma 3"
                                : "Forma 2"
                        )
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 220)
                        .padding(.top, 100)

                        // Sprite da colher (sem a manteiga)
                        Image("Colher")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .rotationEffect(.degrees(spoonRotation))
                            .offset(x: -60, y: -60)
                            .onTapGesture {
                                if !isAnimating && !butterAdded {
                                    isAnimating = true
                                    
                                    play(sound: "poing.mp3")

                                    // Animação da colher girando
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                                        spoonRotation = 120
                                    }

                                    // Animação da manteiga caindo
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        withAnimation(.easeIn(duration: 0.8)) {
                                            butterPosition = CGSize(width: 10, height: 150)
                                            butterOpacity = 0
                                            butterAdded = true
                                        }
                                    }

                                    // Animação da colher voltando
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                        withAnimation(.spring(response: 0.6, dampingFraction: 0.7))
                                        {
                                            spoonRotation = 0
                                            showNextButton = true
                                        }
                                        isAnimating = false
                                    }
                                }
                            }
                        Image("Manteiga")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .offset(x: -15 + butterPosition.width, y: -70 + butterPosition.height)
                            .opacity(butterOpacity)
                            .onTapGesture {
                                if !isAnimating && !butterAdded {
                                    isAnimating = true
                                    
                                    play(sound: "poing.mp3")

                                    // Animação da colher girando
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                                        spoonRotation = 120
                                    }

                                    // Animação da manteiga caindo
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        withAnimation(.easeIn(duration: 0.8)) {
                                            butterPosition = CGSize(width: 10, height: 150)
                                            butterOpacity = 0
                                            butterAdded = true
                                        }
                                    }

                                    // Animação da colher voltando
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                        withAnimation(.spring(response: 0.6, dampingFraction: 0.7))
                                        {
                                            spoonRotation = 0
                                            showNextButton = true
                                        }
                                        isAnimating = false
                                    }
                                }
                            }                    }
                    .frame(maxWidth: .infinity, maxHeight: 350)

                    Spacer()
                }

                // Botão para avançar para a próxima tela
                if showNextButton {
                    VStack {
                        Spacer()

                        Button {
                            play(sound: "blingnext1.mp3")

                            withAnimation(.easeInOut) {
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
            UIImage(named: "Colher"),
            UIImage(named: "Manteiga"),
            UIImage(named: "Bowl 0"),
        ]
    }
}
