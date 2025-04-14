import SwiftUI

struct ContentView: View {
    @State private var step = 0
    @State private var currentTab = 0
    
    var body: some View {
        if step == 0 {
            LaunchScreen(step: $step)
        } else if step == 1 {
            TabView(selection: $currentTab) {
                IngredientsView()
                EquipmentView()
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
        }
    }
}
