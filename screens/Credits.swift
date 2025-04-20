import SwiftUI

struct CreditsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var appeared = false

    var body: some View {
        ZStack {
            // Fundo com gradiente suave
            Color.pink.opacity(0.05)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 30) {
                // Botão de fechar
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation(.spring()) {
                            dismiss()
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.gray)
                            .shadow(color: .black.opacity(0.1), radius: 1)
                    }
                }
                .padding(.top, 16)

                Text("Créditos")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.black)

                VStack(alignment: .leading, spacing: 8) {
                    creditSection(
                        title: "Desenvolvido por",
                        name: "Vicente Parmigiani",
                        icon: "keyboard"
                    )
                    
                    creditSection(
                        title: "Agradecimentos",
                        name: "Apple Developer Academy",
                        icon: "heart.fill"
                    )
                    
                    Divider()
                        .padding(.vertical, 5)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Redes Sociais")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 12) {
                            Link(destination: URL(string: "https://vicx.dev.br")!) {
                                HStack {
                                    Image(systemName: "globe")
                                    Text("Website")
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .background(Color.pink)
                                .clipShape(Capsule())
                                .shadow(color: .black.opacity(0.1), radius: 5, y: 2)
                            }
                            
                            Link(destination: URL(string: "https://linkedin.com/in/vicenteparmi")!) {
                                HStack {
                                    Image(systemName: "link")
                                    Text("LinkedIn")
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .background(Color.blue.opacity(0.8))
                                .clipShape(Capsule())
                                .shadow(color: .black.opacity(0.1), radius: 5, y: 2)
                            }
                        }
                    }
                }
                .opacity(appeared ? 1 : 0)
                .offset(y: appeared ? 0 : 20)

                Spacer()

                Button(action: {
                    withAnimation(.spring()) {
                        dismiss()
                    }
                }) {
                    Text("Voltar")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.pink)
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(0.1), radius: 5, y: 2)
                }
                .opacity(appeared ? 1 : 0)
                .scaleEffect(appeared ? 1 : 0.8)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
        }
        .onAppear {
            withAnimation(.spring().delay(0.3)) {
                appeared = true
            }
        }
    }

    func creditSection(title: String, name: String, icon: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.pink)
                Text(name)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, y: 2)
    }
}
