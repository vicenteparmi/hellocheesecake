//
//  11_strawberry.swift
//  Hello, Cheesecake
//
//  Created by Vicente Parmigiani on 14/04/25.
//

import SwiftUI

struct Strawberry_1: View {
    @Binding var currentTab: Int
    @State var showNextButton: Bool = false
    @State var punchedTimes: Int = 0
    
    // Estados para o sistema de partículas
    @State private var particles: [StrawberryParticle] = []
    @State private var lastTapLocation: CGPoint = .zero
    @State private var timer: Timer?
    
    // Estado para animação de shake
    @State private var shakeOffset: CGFloat = 0
    @State private var isShaking = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    VStack {
                        HStack {
                            Text("Pique os morangos")
                                .font(.title)
                            Spacer()
                        }
                        .padding(.top, 80)
                        .padding(.horizontal, 24)
                        
                        HStack {
                            Text("Agora vamos preparar a calda de morangos. Para isso, pique os morangos em pedaços pequenos (ou bata no liquidificador).")
                                .font(.body)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 16)
                        
                        Spacer()
                        
                        ZStack {
                            // Morangos centralizados
                            Image("Morangos")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .contentShape(Rectangle())
                                .offset(x: shakeOffset)
                                .animation(.interpolatingSpring(stiffness: 300, damping: 5), value: shakeOffset)
                                .position(x: geometry.size.width/2, y: geometry.size.height/2 - 100)
                                .onTapGesture {
                                    if punchedTimes < 5 {
                                        punchedTimes += 1
                                        lastTapLocation = CGPoint(x: geometry.size.width/2, y: geometry.size.height/2 - 100)
                                        createParticles()
                                        
                                        // Vibração mais forte
                                        let generator = UIImpactFeedbackGenerator(style: .heavy)
                                        generator.impactOccurred(intensity: 1.0)
                                        
                                        // Animação de shake
                                        shakeAnimation()
                                        
                                        // Mostrar botão após 5 toques
                                        if punchedTimes >= 5 {
                                            withAnimation {
                                                showNextButton = true
                                            }
                                        }
                                    }
                                }
                            
                            // Sistema de partículas ajustado
                            ForEach(particles) { particle in
                                Image("Morangos")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: particle.size, height: particle.size)
                                    .rotationEffect(.radians(particle.rotation))
                                    .position(particle.position)
                                    .opacity(particle.opacity)
                            }
                            
                            // Contador reposicionado
                            Text("\(punchedTimes)/5")
                                .font(.caption)
                                .padding(8)
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(10)
                                .position(x: geometry.size.width/2, y: geometry.size.height/2)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        // Botão para avançar
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
        .onAppear {
            particles = []
        }
    }
    
    // Função para criar partículas
    private func createParticles() {
        let particleCount = 15
        for _ in 0..<particleCount {
            let angle = Double.random(in: 0...(2 * .pi))
            let speed = CGFloat.random(in: 100...200)
            let velocity = CGPoint(
                x: cos(angle) * speed,
                y: sin(angle) * speed
            )
            
            let particle = StrawberryParticle(
                position: lastTapLocation,
                velocity: velocity,
                size: CGFloat.random(in: 5...12),
                opacity: 1.0,
                rotation: Double.random(in: 0...(2 * .pi))
            )
            
            particles.append(particle)
        }
        
        // Usar RunLoop.main para garantir execução na thread principal
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { _ in
                DispatchQueue.main.async {
                    withAnimation(.linear(duration: 1/60)) {
                        updateParticles()
                    }
                }
            }
            RunLoop.main.add(timer!, forMode: .common)
        }
    }
    
    @MainActor
    private func updateParticles() {
        let gravity = CGPoint(x: 0, y: 500) // Gravidade em pontos por segundo²
        let deltaTime: CGFloat = 1/60
        
        for index in particles.indices {
            var particle = particles[index]
            
            // Atualizar velocidade com gravidade
            particle.velocity.y += gravity.y * deltaTime
            
            // Atualizar posição
            particle.position.x += particle.velocity.x * deltaTime
            particle.position.y += particle.velocity.y * deltaTime
            
            // Diminuir opacidade gradualmente
            particle.opacity -= deltaTime * 1.5
            
            // Atualizar partícula ou remover se invisível
            if particle.opacity > 0 {
                particles[index] = particle
            } else {
                particles.remove(at: index)
                if particles.isEmpty {
                    cleanupTimer()
                }
                break
            }
        }
    }
    
    // Garantir limpeza do timer
    private func cleanupTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // Função para animação de shake
    @MainActor
    private func shakeAnimation() {
        let duration = 0.1
        
        withAnimation(.easeInOut(duration: duration)) {
            shakeOffset = 10
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            withAnimation(.easeInOut(duration: duration)) {
                self.shakeOffset = -10
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                withAnimation(.easeInOut(duration: duration)) {
                    self.shakeOffset = 0
                }
            }
        }
    }
}

// Estrutura para representar partículas de morango
struct StrawberryParticle: Identifiable {
    let id = UUID()
    var position: CGPoint
    var velocity: CGPoint
    var size: CGFloat
    var opacity: Double
    var rotation: Double
}
