import SwiftUI

struct ContentView: View {
    @State private var currentTab = 0

    var body: some View {
        Group {
            switch currentTab {
            case 0:
                LaunchScreen(step: $currentTab)
            case 1:
                IngredientsView(currentTab: $currentTab)
            case 2:
                EquipmentView(currentTab: $currentTab)
            case 3:
                Cookies_1(currentTab: $currentTab)
            case 4:
                Cookies_2(currentTab: $currentTab)
            case 5:
                Cookies_3(currentTab: $currentTab)
            default:
                LaunchScreen(step: $currentTab)
            }
        }
        .background(AnimatedBackground())
        .edgesIgnoringSafeArea(.bottom)
        .edgesIgnoringSafeArea(.top)
    }
}
