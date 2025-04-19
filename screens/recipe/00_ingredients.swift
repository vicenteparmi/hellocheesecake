//
//  00_ingredients.swift
//  Hello, Cheesecake
//
//  Created by Vicente Parmigiani on 14/04/25.
//
import SwiftUI

struct IngredientsView: View {
    @Binding var currentTab: Int
    @State private var showAlert = false
    @State private var selectedIngredients = Set<String>()

    var body: some View {
        VStack {
            VStack() {
                HStack {
                    Text("Vamos preparar os ingredientes?")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.top, 80)
                .padding(.leading, 24)
                .padding(.bottom, 16)

                HStack {
                    Text(
                        "Para preparar um delicioso cheesecake de morango vocë precisa juntar todos os ingredientes abaixo."
                    )
                    .font(.body)
                    .foregroundColor(.black)
                    Spacer()
                }
                .padding(.leading, 24)

                ScrollView {
                    Spacer(minLength: 32)
                    
                    Button {
                        if selectedIngredients.count == 9 {
                            selectedIngredients.removeAll()
                        } else {
                            selectedIngredients = Set(["Cream Cheese", "Manteiga", "Creme de leite", 
                                "Leite condensado", "Gelatina em pó", "Nata", "Morango", 
                                "Açúcar", "Bolacha de maisena"])
                        }
                    } label: {
                        HStack {
                            Image(systemName: selectedIngredients.count == 9 ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(.orange)
                            Text("Selecionar Todos")
                                .foregroundColor(.black)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 1)
                    }

                    IngredientCardView(
                        ingredientName: "Cream Cheese",
                        ingredientQuantity: "500g",
                        ingredientImage: "Cream Cheese",
                        isSelected: selectedIngredients.contains("Cream Cheese"),
                        onTap: { toggleIngredient("Cream Cheese") }
                    )
                    IngredientCardView(
                        ingredientName: "Manteiga",
                        ingredientQuantity: "100g",
                        ingredientImage: "Manteiga",
                        isSelected: selectedIngredients.contains("Manteiga"),
                        onTap: { toggleIngredient("Manteiga") }
                    )
                    IngredientCardView(
                        ingredientName: "Creme de leite",
                        ingredientQuantity: "200g",
                        ingredientImage: "Creme de Leite",
                        isSelected: selectedIngredients.contains("Creme de leite"),
                        onTap: { toggleIngredient("Creme de leite") }
                    )
                    IngredientCardView(
                        ingredientName: "Leite condensado",
                        ingredientQuantity: "1 lata",
                        ingredientImage: "Leite Condensado",
                        isSelected: selectedIngredients.contains("Leite condensado"),
                        onTap: { toggleIngredient("Leite condensado") }
                    )
                    IngredientCardView(
                        ingredientName: "Gelatina em pó",
                        ingredientQuantity: "1 pacote",
                        ingredientImage: "Gelatina",
                        isSelected: selectedIngredients.contains("Gelatina em pó"),
                        onTap: { toggleIngredient("Gelatina em pó") }
                    )
                    IngredientCardView(
                        ingredientName: "Nata",
                        ingredientQuantity: "200g",
                        ingredientImage: "Nata",
                        isSelected: selectedIngredients.contains("Nata"),
                        onTap: { toggleIngredient("Nata") }
                    )
                    IngredientCardView(
                        ingredientName: "Morango",
                        ingredientQuantity: "1 caixa",
                        ingredientImage: "Morangos",
                        isSelected: selectedIngredients.contains("Morango"),
                        onTap: { toggleIngredient("Morango") }
                    )
                    IngredientCardView(
                        ingredientName: "Açúcar",
                        ingredientQuantity: "100g",
                        ingredientImage: "Açúcar",
                        isSelected: selectedIngredients.contains("Açúcar"),
                        onTap: { toggleIngredient("Açúcar") }
                    )
                    IngredientCardView(
                        ingredientName: "Bolacha de maisena",
                        ingredientQuantity: "1 pacote",
                        ingredientImage: "Bolacha 0",
                        isSelected: selectedIngredients.contains("Bolacha de maisena"),
                        onTap: { toggleIngredient("Bolacha de maisena") }
                    )
                    Spacer(minLength: 24)
                }
                .padding(.horizontal, 24)
                .mask(
                    VStack(spacing: 0) {
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, .black]),
                            startPoint: .top,
                            endPoint: .bottom
                        ).frame(height: 32)
                        
                        Rectangle().fill(Color.black)
                        
                        LinearGradient(
                            gradient: Gradient(colors: [.black, .clear]),
                            startPoint: .top,
                            endPoint: .bottom
                        ).frame(height: 32)
                    }
                )
                
                Button {
                    if selectedIngredients.count == 9 {
                        withAnimation {
                            currentTab = 2
                        }
                    } else {
                        showAlert = true
                    }
                } label: {
                    Text("Próximo")
                        .foregroundStyle(.white)
                        .font(.custom("Poppins-Bold", size: 18))
                        .fontWeight(.bold)
                        .padding(48)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                }
                .background(.pink)
                .cornerRadius(12)
                .shadow(radius: 8, x: 0, y: 4)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
                .alert("Ingredientes Faltando", isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("Por favor, selecione todos os ingredientes antes de continuar.")
                }
            }
        }
    }

    private func toggleIngredient(_ ingredient: String) {
        if selectedIngredients.contains(ingredient) {
            selectedIngredients.remove(ingredient)
        } else {
            selectedIngredients.insert(ingredient)
        }
    }
}

struct IngredientCardView: View {
    var ingredientName: String = "Ingredient Name"
    var ingredientQuantity: String = "100g"
    var ingredientImage: String = "carrot"
    var isSelected: Bool
    var onTap: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(1))
                .shadow(radius: 1)

            HStack {
                Image(ingredientImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .padding(.leading, 16)

                VStack(alignment: .leading, spacing: 8) {
                    Text(ingredientName)
                        .font(.headline)
                        .foregroundColor(.black)

                    Text(ingredientQuantity)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 16)

                Spacer()

                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 30))
                    .foregroundColor(.orange)
                    .padding(.trailing, 16)
            }
        }
        .frame(height: 100)
        .onTapGesture(perform: onTap)
    }
}
