import SwiftUI
import WebKit
struct PlaybackView:View{
 @EnvironmentObject var config:DVRConfigStore
 @State var channel=1
 @State var date=Date()
 var body:some View{NavigationStack{Form{Section("DVR archive"){Picker("Camera",selection:$channel){ForEach(1...16,id:\.self){Text("CAM \($0)").tag($0)}};DatePicker("Date",selection:$date,displayedComponents:.date);Button("Search DVR archive"){ };if let u=config.webURL(){NavigationLink("Open Kestrel Web Playback"){KestrelWebView(url:u).ignoresSafeArea()}}else{Text("Set DVR host in Settings")}};Section("Archive flow"){Text("Camera → date/time → DVR HDD search → playback. Native HDD protocol is isolated for the next protocol-analysis step.").font(.footnote)}}.navigationTitle("Playback")}}
struct KestrelWebView:UIViewRepresentable{let url:URL;func makeUIView(context:Context)->WKWebView{let w=WKWebView();w.load(URLRequest(url:url));return w};func updateUIView(_ uiView:WKWebView,context:Context){}}
