import SwiftUI

struct LaunchScreen: View {
    @Binding public var step : Int
    
    let brown = Color(red: 47/255, green: 23/255, blue: 15/255)
    let fadedYellow: Color = .orange.opacity(0.1)
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                DrippingShape()
                    .fill(.pink)
                    .frame(width: geometry.size.width, height: geometry.size.height / 6)
                Spacer()
                Text("Hello,")
                    .italic()
                    .font(.title)
                Spacer()
                    .frame(height: 12)
                Text("Cheesecake!")
                    .font(.custom("Poppins-Bold", size: 40))
                    .fontWeight(.bold)
                Spacer()
                    .frame(height: 32)
                // Begin button
                Button {
                    withAnimation {
                        step = 1
                    }
                } label: {
                    Text("Começar")
                        .foregroundStyle(.white)
                        .font(.custom("Poppins-Bold", size: 18))
                        .fontWeight(.bold)
                        .padding(64)
                        .frame(width: Double.infinity, height: 50)
                }
                .background(.pink)
                .cornerRadius(12)
                .shadow(radius: 8, x: 0, y: 4)
                
                
                Spacer()
                // Block solid
                CookiePart()
                    .frame(width: geometry.size.width, height: geometry.size.height / 6)
                    
            }
            .background(fadedYellow)
            .edgesIgnoringSafeArea(.bottom)
            .edgesIgnoringSafeArea(.top)
        }
    }
}
