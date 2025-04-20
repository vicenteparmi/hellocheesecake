//
//  01_equipments.swift
//  Hello, Cheesecake
//
//  Created by Vicente Parmigiani on 14/04/25.
//

import SwiftUI

struct EquipmentView: View {
    @Binding var currentTab: Int
    @State private var showAlert = false
    @State private var selectedEquipments = Set<String>()

    var body: some View {
        VStack {
            VStack() {
                HStack {
                    Text("Vamos separar os utensílios?")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.top, 80)
                .padding(.leading, 24)
                .padding(.bottom, 16)

                HStack {
                    Text(
                        "Para preparar o cheesecake você precisa separar todos os utensílios abaixo."
                    )
                    .font(.body)
                    .foregroundColor(.black)
                    Spacer()
                }
                .padding(.leading, 24)

                ScrollView {
                    Spacer(minLength: 32)
                    
                    Button {
                        if selectedEquipments.count == 6 {
                            selectedEquipments.removeAll()
                        } else {
                            selectedEquipments = Set(["Tigela", "Batedeira", "Liquidificador", 
                                "Forma", "Forno", "Espátula"])
                        }
                    } label: {
                        HStack {
                            Image(systemName: selectedEquipments.count == 6 ? "checkmark.circle.fill" : "circle")
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

                    EquipmentCardView(
                        equipmentName: "Tigela",
                        equipmentDescription: "Grande",
                        equipmentImage: "Bowl 0",
                        isSelected: selectedEquipments.contains("Tigela"),
                        onTap: { toggleEquipment("Tigela") }
                    )
                    EquipmentCardView(
                        equipmentName: "Batedeira",
                        equipmentDescription: "Se você estiver motivado a misturar na mão não precisa",
                        equipmentImage: "Batedeira Off",
                        isSelected: selectedEquipments.contains("Batedeira"),
                        onTap: { toggleEquipment("Batedeira") }
                    )
                    EquipmentCardView(
                        equipmentName: "Liquidificador",
                        equipmentDescription: "Para triturar os morangos",
                        equipmentImage: "Liqui 0",
                        isSelected: selectedEquipments.contains("Liquidificador"),
                        onTap: { toggleEquipment("Liquidificador") }
                    )
                    EquipmentCardView(
                        equipmentName: "Forma",
                        equipmentDescription: "24cm de fundo removível",
                        equipmentImage: "Forma 0",
                        isSelected: selectedEquipments.contains("Forma"),
                        onTap: { toggleEquipment("Forma") }
                    )
                    EquipmentCardView(
                        equipmentName: "Forno",
                        equipmentDescription: "Pré-aquecido a 180°C",
                        equipmentImage: "Forno 0",
                        isSelected: selectedEquipments.contains("Forno"),
                        onTap: { toggleEquipment("Forno") }
                    )
                    EquipmentCardView(
                        equipmentName: "Espátula",
                        equipmentDescription: "Para misturar os ingredientes",
                        equipmentImage: "Colher",
                        isSelected: selectedEquipments.contains("Espátula"),
                        onTap: { toggleEquipment("Espátula") }
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
                    if selectedEquipments.count == 6 {
                        withAnimation {
                            currentTab = 3
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
                .background(.orange)
                .cornerRadius(12)
                .shadow(radius: 8, x: 0, y: 4)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
                .alert("Utensílios Faltando", isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("Por favor, selecione todos os utensílios antes de continuar.")
                }
            }
        }
    }

    private func toggleEquipment(_ equipment: String) {
        if selectedEquipments.contains(equipment) {
            selectedEquipments.remove(equipment)
        } else {
            selectedEquipments.insert(equipment)
        }
    }
}

struct EquipmentCardView: View {
    var equipmentName: String = "Equipment Name"
    var equipmentDescription: String = "Description"
    var equipmentImage: String = "pan"
    var isSelected: Bool
    var onTap: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(1))
                .shadow(radius: 1)

            HStack {
                Image(equipmentImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .padding(.leading, 16)

                VStack(alignment: .leading, spacing: 8) {
                    Text(equipmentName)
                        .font(.headline)
                        .foregroundColor(.black)

                    Text(equipmentDescription)
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
