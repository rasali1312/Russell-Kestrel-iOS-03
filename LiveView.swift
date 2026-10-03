import SwiftUI
struct LiveView:View{
 @EnvironmentObject var config:DVRConfigStore
 @State var grid:ViewerGrid = .four
 @State var profile:StreamProfile = .sub
 var body:some View{NavigationStack{VStack(spacing:0){HStack{Menu("Grid") {ForEach(ViewerGrid.allCases){g in Button(g.title){grid=g}}};Picker("Stream",selection:$profile){Text("Main").tag(StreamProfile.main);Text("Sub").tag(StreamProfile.sub)}.pickerStyle(.segmented).frame(maxWidth:190)}.padding(8);ScrollView{LazyVGrid(columns:Array(repeating:GridItem(.flexible(),spacing:2),count:grid.columns),spacing:2){ForEach(1...grid.rawValue,id:\.self){c in CameraTile(channel:c,url:config.rtspURL(channel:c,profile:profile)).aspectRatio(16/9,contentMode:.fit)}}.padding(2)}}.navigationTitle("Russell Viewer 0.3")}}
struct CameraTile:View{let channel:Int;let url:URL?;var body:some View{ZStack(alignment:.topLeading){Color.black;if let u=url{VLCPlayerView(url:u)}else{Text("Set DVR host / RTSP path").font(.caption).foregroundStyle(.secondary).frame(maxWidth:.infinity,maxHeight:.infinity)};Text("CAM \(channel)").font(.caption.bold()).padding(5).background(.black.opacity(.7))}}}
