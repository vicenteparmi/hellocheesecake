//
//  03_cookies_2.swift
//  Hello, Cheesecake
//
//  Created by Vicente Parmigiani on 14/04/25.
//

import SwiftUI
import SpriteKit

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
                        Spacer()
                    }
                    .padding(.top, 80)
                    .padding(.horizontal, 24)
                    
                    HStack {
                        Text("Agora é hora de adicionar manteiga à nossa mistura de cookies. Clique na colher para despejar a manteiga na tigela.")
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
                        Image("bowl")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 180)
                            .padding(.top, 100)
                        
                        // Conteúdo da tigela (farofa de cookies)
                        Circle()
                            .fill(Color.brown.opacity(0.5))
                            .frame(width: 110, height: 50)
                            .offset(y: 100)
                        
                        // Manteiga derretida na tigela (aparece quando butterAdded = true)
                        if butterAdded {
                            Circle()
                                .fill(Color.yellow.opacity(0.7))
                                .frame(width: 100, height: 40)
                                .offset(y: 95)
                                .transition(.opacity)
                        }
                        
                        // Sprite da manteiga (separada da colher)
                        Image("butter")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .offset(x: -40 + butterPosition.width, y: -50 + butterPosition.height)
                            .opacity(butterOpacity)
                        
                        // Sprite da colher (sem a manteiga)
                        Image("spoon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .rotationEffect(.degrees(spoonRotation))
                            .offset(x: -50, y: -50)
                            .onTapGesture {
                                if !isAnimating && !butterAdded {
                                    isAnimating = true
                                    
                                    // Animação da colher girando
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                                        spoonRotation = 120
                                    }
                                    
                                    // Animação da manteiga caindo
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        withAnimation(.easeIn(duration: 0.8)) {
                                            butterPosition = CGSize(width: 40, height: 150)
                                            butterOpacity = 0
                                            butterAdded = true
                                        }
                                    }
                                    
                                    // Animação da colher voltando
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                        withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                                            spoonRotation = 0
                                            showNextButton = true
                                        }
                                        isAnimating = false
                                    }
                                }
                            }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    
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
                        .animation(.spring(response: 0.6, dampingFraction: 0.7), value: showNextButton)
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
            UIImage(named: "spoon"),
            UIImage(named: "butter"),
            UIImage(named: "bowl")
        ]
    }
}

