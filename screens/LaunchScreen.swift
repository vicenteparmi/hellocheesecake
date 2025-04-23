import AVFoundation
import SwiftUI
import Subsonic

struct LaunchScreen: View {
    @Binding public var step: Int
    @State var pulseScale = 1.0
    @State private var audioPlayer: AVAudioPlayer?

    let brown = Color(red: 47 / 255, green: 23 / 255, blue: 15 / 255)
    let fadedYellow: Color = .orange.opacity(0.1)

    var body: some View {
        GeometryReader { geometry in
            VStack {
                DrippingShape()
                    .fill(.pink)
                    .frame(width: geometry.size.width, height: geometry.size.height / 6)
                Spacer()
                Image("Hello Logo")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(pulseScale)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                            pulseScale = 0.9
                        }
                    }
                    .frame(width: geometry.size.width - 48)
                    .padding(.top, 32)
                Spacer()
                    .frame(height: 32)
                // Begin button
                Button {
                    play(sound: "blingnextphase.mp3")
                    withAnimation {
                        step = 1
                    }

                } label: {
                    Text("Começar")
                        .foregroundStyle(.white)
                        .font(.custom("Poppins-Bold", size: 18))
                        .fontWeight(.bold)
                        .padding()
                        .frame(width: Double.infinity, height: 50)
                }
                .background(.pink)
                .cornerRadius(54)
                .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 2)

                Spacer()
                // Block solid
                CookiePart()
                    .frame(width: geometry.size.width, height: geometry.size.height / 6)

            }
            .background(AnimatedBackgroundHome())
            .background(Color.white)
            .edgesIgnoringSafeArea(.bottom)
            .edgesIgnoringSafeArea(.top)
        }
    }
}
