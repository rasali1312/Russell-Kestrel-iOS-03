import SwiftUI
struct ContentView: View {
 @EnvironmentObject var config:DVRConfigStore
 var body:some View{TabView{LiveView().tabItem{Label("Live",systemImage:"video")};PlaybackView().tabItem{Label("Playback",systemImage:"clock.arrow.circlepath")};SettingsView().tabItem{Label("Settings",systemImage:"gearshape")}}.tint(.cyan)}
}
