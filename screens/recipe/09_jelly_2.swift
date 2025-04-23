//
//  09_jelly_2.swift
//  Hello, Cheesecake
//
//  Created by Vicente Parmigiani on 19/04/25.
//
import SwiftUI
import Subsonic

struct Jelly_2: View {
    @Binding var currentTab: Int
    @State var showNextButton: Bool = false
    @State var isActive: Bool = false
    @State private var timer: Timer?
    @State private var xOffset: CGFloat = 0
    @State private var hasCompleted: Bool = false
    @StateObject private var sound = SubsonicPlayer(sound: "beating.mp3")
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    HStack {
                        Text("Misture a gelatina")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.top, 80)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)

                    HStack {
                        Text("Use a batedeira para misturar a gelatina na tigela até obter uma mistura homogênea.")
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
                        Image(isActive ? "Batedeira On" : "Batedeira Off")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 130)
                            .offset(x: xOffset, y: isActive ? -100 : -150)
                            .animation(.easeInOut(duration: 0.5), value: isActive)
                            .onTapGesture {
                                if hasCompleted {
                                    return
                                }
                                
                                isActive.toggle()
                                
                                if isActive {
                                    // Toca o som de mistura
                                    sound.play()
                                    // Inicia a animação lateral
                                    withAnimation(.easeInOut(duration: 0.3).repeatForever(autoreverses: true)) {
                                        xOffset = 20
                                    }
                                    
                                    // Inicia o timer para contar 5 segundos continuamente
                                    timer?.invalidate()
                                    timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                                        DispatchQueue.main.async {
                                            isActive = false
                                            hasCompleted = true
                                            showNextButton = true
                                            withAnimation {
                                                xOffset = 0
                                            }
                                        }
                                    }
                                    
                                } else {
                                    // Para o som
                                    sound.stop()
                                    // Cancela o timer se parar antes
                                    timer?.invalidate()
                                    withAnimation {
                                        xOffset = 0
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
                        .animation(.spring(response: 0.6, dampingFraction: 0.7), value: showNextButton)
                    }
                }
            }
        }
    }
}
