import SwiftUI

struct ContentView: View {
    @State private var currentTab = 14

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
                Oven(currentTab: $currentTab)
            case 6:
                Mix_1(currentTab: $currentTab)
            case 7:
                Mix_2(currentTab: $currentTab)
            case 8:
                Jelly_1(currentTab: $currentTab)
            case 9:
                Jelly_2(currentTab: $currentTab)
            case 10:
                Fridge(currentTab: $currentTab)
            case 11:
                Strawberry_1(currentTab: $currentTab)
            case 12:
                Strawberry_2(currentTab: $currentTab)
            case 13:
                Combining(currentTab: $currentTab)
            case 14:
                ClosureView(currentTab: $currentTab)
            default:
                LaunchScreen(step: $currentTab)
            }
        }
        .background(AnimatedBackground())
        .background(Color.white)
        .edgesIgnoringSafeArea(.bottom)
        .edgesIgnoringSafeArea(.top)
    }
}
