//
//  02_cookies_1.swift
//  Hello, Cheesecake
//
//  Created by Vicente Parmigiani on 14/04/25.
//

import SwiftUI

struct Cookies_1: View {
    @Binding var currentTab: Int
    @State private var cookiesOnBlender = 0
    @State private var remainingCookies = 6
    @State private var blendedCookies = 0
    @State private var showNextButton = false

    @State private var isBlending = false

    var body: some View {
        VStack {
            ZStack {
                VStack {
                    HStack {
                        Text("Vamos começar com as bolachas")
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
                            "Coloque as bolachas de maisena no liquidificador e bata até virar uma farofa. Mas cuidado! Você precisa adicionar aos poucos para não quebrar o liquidificador."
                        )
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
                        Image(
                            cookiesOnBlender == 3
                                ? "Liqui 3"
                                : cookiesOnBlender == 2
                                    ? "Liqui 2"
                                    : cookiesOnBlender == 1
                                        ? "Liqui 1" : "Liqui 0"
                        )
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding(.bottom, 16)
                        .modifier(
                            ShakeEffect(
                                animatableData: isBlending
                                    ? CGFloat(Date().timeIntervalSince1970).truncatingRemainder(
                                        dividingBy: 10) : 0)
                        )
                        .animation(
                            isBlending
                                ? Animation.linear(duration: 0.1).repeatForever(autoreverses: true)
                                : .default, value: isBlending)
                        .onTapGesture {
                            if cookiesOnBlender > 2 && !isBlending {
                                play(sound: "errorliqui.mp3")
                                // Alerta avisando para colocar menos cookies no liquidificador para moer melhor
                                let alert = UIAlertController(
                                    title: "Atenção",
                                    message:
                                        "Coloque menos bolacha no liquidificador para moer melhor.",
                                    preferredStyle: .alert
                                )
                                alert.addAction(UIAlertAction(title: "OK", style: .default))
                                
                                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                   let rootViewController = windowScene.windows.first?.rootViewController {
                                    rootViewController.present(alert, animated: true)
                                }
                            } else if cookiesOnBlender > 0 {
                                isBlending = true
                                
                                play(sound: "liquimix1.mp3")
                                
                                // Para após 2 segundos
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    isBlending = false
                                    blendedCookies += cookiesOnBlender
                                    cookiesOnBlender = 0
                                    
                                    // Verifica se todos já foram batidos
                                    if blendedCookies == 6 {
                                        showNextButton = true
                                    } else {
                                        // Se não, mostra o botão "Continuar"
                                        showNextButton = false
                                    }
                                }
                            }
                        }

                        // Cookies inteiros e batidos lado a lado

                        HStack(alignment: .bottom, spacing: -30) {
                            // Mostra os cookies conforme cookiesRemaining em uma pilha de imagens
                            HStack(alignment: .bottom, spacing: 0) {

                                if remainingCookies > 5 {
                                    Image("Bolacha 3")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 100, alignment: .bottom)
                                        .padding(4)
                                } else if remainingCookies > 4 {
                                    Image("Bolacha 2")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 100, alignment: .bottom)
                                        .padding(4)
                                } else if remainingCookies > 3 {
                                    Image("Bolacha 1")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 100, alignment: .bottom)
                                        .padding(4)
                                }

                                if remainingCookies > 2 {
                                    Image("Bolacha 3")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 100, alignment: .bottom)
                                        .padding(4)
                                } else if remainingCookies > 1 {
                                    Image("Bolacha 2")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 100, alignment: .bottom)
                                        .padding(4)
                                } else if remainingCookies > 0 {
                                    Image("Bolacha 1")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 100, alignment: .bottom)
                                        .padding(4)
                                }
                            }
                            .frame(
                                maxWidth: .infinity,
                                minHeight: 100,
                                maxHeight: 100,
                                alignment: .bottomTrailing)
                            .onTapGesture {
                                play(sound: "buttonpleck.mp3")
                                
                                if remainingCookies > 0 && cookiesOnBlender < 3 {
                                    cookiesOnBlender += 1
                                    remainingCookies -= 1
                                }
                            }

                            Spacer()
                                .frame(width: 16)
                            VStack {
                                Image(
                                    blendedCookies > 5
                                        ? "Forma 2"
                                        : blendedCookies > 1
                                            ? "Forma 1"
                                            : "Forma 0"
                                )
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 70, alignment: .bottom)
                                .padding(4)
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }

                    Spacer()

                    // Controles
                    HStack {

                        // Botão para adicionar um cookie
                        Button {
                            play(sound: "buttonpleck.mp3")
                            
                            if remainingCookies > 0 && cookiesOnBlender < 3 {
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
                        .disabled(isBlending)
                        .opacity(isBlending ? 0.5 : 1)

                        // Botão para bater os cookies no liquidificador (alternar)
                        Button {
                            if cookiesOnBlender > 2 && !isBlending {
                                play(sound: "errorliqui.mp3")
                                // Alerta avisando para colocar menos cookies no liquidificador para moer melhor
                                let alert = UIAlertController(
                                    title: "Atenção",
                                    message:
                                        "Coloque menos bolacha no liquidificador para moer melhor.",
                                    preferredStyle: .alert
                                )
                                alert.addAction(UIAlertAction(title: "OK", style: .default))
                                
                                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                   let rootViewController = windowScene.windows.first?.rootViewController {
                                    rootViewController.present(alert, animated: true)
                                }
                            } else if cookiesOnBlender > 0 {
                                isBlending = true
                                
                                play(sound: "liquimix1.mp3")

                                // Para após 2 segundos
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    isBlending = false
                                    blendedCookies += cookiesOnBlender
                                    cookiesOnBlender = 0

                                    // Verifica se todos já foram batidos
                                    if blendedCookies == 6 {
                                        showNextButton = true
                                    } else {
                                        // Se não, mostra o botão "Continuar"
                                        showNextButton = false
                                    }
                                }
                            }
                        } label: {
                            Image(
                                systemName: !isBlending ? "play.circle.fill" : "pause.circle.fill"
                            )
                            .foregroundColor(.orange)
                            .font(.title)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 1)
                        .disabled(cookiesOnBlender == 0)
                        .opacity(cookiesOnBlender == 0 ? 0.5 : 1)
                        .animation(
                            .spring(response: 0.6, dampingFraction: 0.7), value: isBlending
                        )
                        .padding(.trailing, 16)

                        // Botão para remover um cookie do liquidificador
                        Button {
                            play(sound: "buttonpleck.mp3")
                            
                            if cookiesOnBlender > 0 {
                                remainingCookies += 1
                                cookiesOnBlender -= 1
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
                        .disabled(isBlending)
                        .opacity(isBlending ? 0.5 : 1)
                    }
                    .padding(.bottom, showNextButton ? 80 : 32)  // Adiciona espaço adicional quando o botão "Continuar" está visível
                    .animation(.spring(response: 0.6, dampingFraction: 0.7), value: showNextButton)

                    Spacer()
                        .frame(height: 32)
                }

                // Botão para avançar para a próxima tela
                if showNextButton {
                    VStack {
                        Spacer()

                        Button {
                            play(sound: "blingnext1.mp3")
                            
                            withAnimation(.easeInOut) {
                                // Avança para a próxima tela
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

// Is blending animation
struct ShakeEffect: GeometryEffect {
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(
            CGAffineTransform(
                translationX:
                    sin(animatableData * .pi * 8) * 3,
                y: cos(animatableData * .pi * 12) * 2))
    }
}
