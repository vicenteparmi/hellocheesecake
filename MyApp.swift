import SwiftUI

@main
struct MyApp: App {
    @StateObject private var stepsData = StepsData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(stepsData)
        }
    }
}
