//
//  02_cookies_1.swift
//  Hello, Cheesecake
//
//  Created by Vicente Parmigiani on 14/04/25.
//

import SwiftUI

struct Cookies_1: View {
    @Binding var currentTab: Int
    @State private var cookiesOnBlender = 0;
    @State private var remainingCookies = 3;
    @State private var blendedCookies = 0;
    @State private var showNextButton = false;
    
    @State private var isBlending = false;
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    HStack {
                        Text("Vamos começar com as bolachas")
                            .font(.title)
                        Spacer()
                    }
                    .padding(.top, 80)
                    .padding(.horizontal, 24)
                    
                    HStack {
                        Text("Coloque as bolachas de maisena no liquidificador e bata até virar uma farofa. Mas cuidado! Você precisa adicionar aos poucos para não quebrar o liquidificador.")
                            .font(.body)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
                    
                    Spacer()
                    
                    // Interface para adicionar cookies e bater no liquidificador
                    VStack {
                        // Imagem do liquidificador
                        Image("blender")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding(.bottom, 16)
                        
                        // Cookies inteiros e batidos lado a lado
                        HStack {
                            VStack {
                                // Mostra os cookies conforme cookiesRemaining em uma pilha de imagens
                                ForEach(0..<remainingCookies, id: \.self) { _ in
                                    Image("cookie")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .padding(4)
                                    
                                    // Adiciona um espaço entre os cookies
                                    Spacer()
                                        .frame(height: 4)
                                    
                                }
                            }

                        }
                    }
                    
                    Spacer()
                    
                    // Controles
                    HStack {
                        
                        // Botão para adicionar um cookie
                        Button {
                            if cookiesOnBlender < 3 {
                                cookiesOnBlender += 1
                                remainingCookies -= 1
                            }
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.orange)
                                .font(.title)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 1)
                        .padding(.trailing, 16)
                        
                        // Botão para bater os cookies no liquidificador (alternar)
                        Button {
                            isBlending.toggle()
                        } label: {
                            Image(systemName: isBlending ? "play.circle.fill" : "pause.circle.fill")
                                .foregroundColor(.orange)
                                .font(.title)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 1)
                        .padding(.trailing, 16)
                        
                        // Botão para remover um cookie do liquidificador
                        Button {
                            if blendedCookies < 3 && cookiesOnBlender > 0 {
                                blendedCookies += 1
                                cookiesOnBlender -= 1
                                
                                // Verificar se todos os cookies foram moídos
                                if blendedCookies == 3 {
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                                        showNextButton = true
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: "minus.circle.fill")
                                .foregroundColor(.orange)
                                .font(.title)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 1)
                    }
                    .padding(.bottom, showNextButton ? 80 : 32) // Adiciona espaço adicional quando o botão "Continuar" está visível
                    .animation(.spring(response: 0.6, dampingFraction: 0.7), value: showNextButton)
                    
                    Spacer()
                        .frame(height: 32)
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
    }
}
