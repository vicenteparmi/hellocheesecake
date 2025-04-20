//
//  06_mix_1.swift
//  Hello, Cheesecake
//
//  Created by Vicente Parmigiani on 14/04/25.
//

import SwiftUI

struct Mix_1: View {
    @Binding var currentTab: Int
    @State var showNextButton: Bool = false
    @State var ingredientsAdded: Int = 0
    
    // Novos estados para controlar a visibilidade dos ingredientes
    @State private var ingredients: [Bool] = [true, true, true, true]
    @State private var positions: [CGPoint] = Array(repeating: .zero, count: 4)
    @State private var bowlCenter: CGPoint = .zero

    var bowlImage: String {
        return ingredientsAdded >= 3 ? "Bowl 1" : "Bowl 0"
    }
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    HStack {
                        Text("Misture os ingredientes")
                            .font(.title)
                        Spacer()
                    }
                    .padding(.top, 80)
                    .padding(.horizontal, 24)

                    HStack {
                        Text(
                            "Misture o leite condensado, o creme de leite, o cream cheese e a nata em uma tigela. Clique em cada um para adicionar à tigela."
                        )
                        .font(.body)
                        .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)

                    Spacer()

                    // Ingredientes
                    HStack {
                        Image("Leite Condensado")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / 5, height: UIScreen.main.bounds.width / 5)
                            .opacity(ingredients[0] ? 1 : 0)
                            .offset(x: positions[0].x, y: positions[0].y)
                            .padding(.top, 0)
                            .onTapGesture {
                                if ingredients[0] {
                                    withAnimation(.easeInOut(duration: 0.7)) {
                                        positions[0] = CGPoint(x: UIScreen.main.bounds.width/3, y: 200)
                                        ingredients[0] = false
                                        ingredientsAdded += 1
                                    }
                                    if ingredientsAdded == 3 {
                                        showNextButton = true
                                    }
                                }
                            }

                        Image("Creme de Leite")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / 5, height: UIScreen.main.bounds.width / 5)
                            .opacity(ingredients[1] ? 1 : 0)
                            .offset(x: positions[1].x, y: positions[1].y)
                            .padding(.top, 0)
                            .onTapGesture {
                                if ingredients[1] {
                                    withAnimation(.easeInOut(duration: 0.7)) {
                                        positions[1] = CGPoint(x: UIScreen.main.bounds.width/6, y: 200)
                                        ingredients[1] = false
                                        ingredientsAdded += 1
                                    }
                                    if ingredientsAdded == 3 {
                                        showNextButton = true
                                    }
                                }
                            }

                        Image("Nata")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / 5, height: UIScreen.main.bounds.width / 5)
                            .opacity(ingredients[2] ? 1 : 0)
                            .offset(x: positions[2].x, y: positions[2].y)
                            .padding(.top, 0)
                            .onTapGesture {
                                if ingredients[2] {
                                    withAnimation(.easeInOut(duration: 0.7)) {
                                        positions[2] = CGPoint(x: -UIScreen.main.bounds.width/6, y: 200)
                                        ingredients[2] = false
                                        ingredientsAdded += 1
                                    }
                                    if ingredientsAdded == 3 {
                                        showNextButton = true
                                    }
                                }
                            }

                        Image("Cream Cheese")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / 5, height: UIScreen.main.bounds.width / 5)
                            .opacity(ingredients[3] ? 1 : 0)
                            .offset(x: positions[3].x, y: positions[3].y)
                            .padding(.top, 0)
                            .onTapGesture {
                                if ingredients[3] {
                                    withAnimation(.easeInOut(duration: 0.7)) {
                                        positions[3] = CGPoint(x: -UIScreen.main.bounds.width/3, y: 200)
                                        ingredients[3] = false
                                        ingredientsAdded += 1
                                    }
                                    if ingredientsAdded == 3 {
                                        showNextButton = true
                                    }
                                }
                            }
                    }
                    .padding(.horizontal, 24)

                    Spacer()
                        .frame(height: 20)

                    // Tigela
                    Image(bowlImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding(.top, 0)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 16)
                        .onAppear {
                            bowlCenter = CGPoint(x: 0, y: 200)
                        }

                    
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
            UIImage(named: "Leite Condensado"),
            UIImage(named: "Creme de Leite"),
            UIImage(named: "Nata"),
            UIImage(named: "Cream Cheese"),
        ]
    }
}
